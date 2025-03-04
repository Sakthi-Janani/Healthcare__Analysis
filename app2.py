import pickle
import streamlit as st
import pandas as pd

# ------------------------- Load Models & Encoders -------------------------

@st.cache_resource
def load_models():
    """Loads the inpatient and outpatient models from pickle files."""
    try:
        with open("inpatient_model.pkl", "rb") as f:
            inpatient_model = pickle.load(f)
        with open("outpatient_model.pkl", "rb") as f:
            outpatient_model = pickle.load(f)
        return inpatient_model, outpatient_model
    except FileNotFoundError:
        st.error("❌ Model files not found. Please check the file paths.")
        return None, None

@st.cache_resource
def load_encoders():
    """Loads the label encoders for inpatient and outpatient services."""
    try:
        with open("le_drg.pkl", "rb") as f:
            inpatient_le_drg = pickle.load(f)
        with open("le_state.pkl", "rb") as f:
            inpatient_le_state = pickle.load(f)
        with open("le_drg_outpatient.pkl", "rb") as f:
            outpatient_le_apc = pickle.load(f)
        with open("le_state_outpatient.pkl", "rb") as f:
            outpatient_le_state = pickle.load(f)
        return inpatient_le_drg, inpatient_le_state, outpatient_le_apc, outpatient_le_state
    except FileNotFoundError:
        st.error("❌ Encoder files not found. Please check the file paths.")
        return None, None, None, None

# ------------------------- Login System -------------------------

# Securely store credentials (Replace with a proper authentication system)
USER_CREDENTIALS = {
    "admin": "password123",
    "user": "medi123"
}

def initialize_session_state():
    """Initializes session state variables if not already set."""
    if "logged_in" not in st.session_state:
        st.session_state["logged_in"] = False
    if "username" not in st.session_state:
        st.session_state["username"] = None

def login_page():
    """Displays the login page."""
    st.title("🔐 MediRank - Login")
    st.write("Please enter your credentials to access the hospital ranking system.")

    username = st.text_input("Username")
    password = st.text_input("Password", type="password")

    if st.button("Login"):
        if username in USER_CREDENTIALS and USER_CREDENTIALS[username] == password:
            st.session_state["logged_in"] = True
            st.session_state["username"] = username
            st.success(f"✅ Welcome, {username}! Redirecting...")
            st.rerun()

        else:
            st.error("❌ Invalid username or password.")

def logout():
    """Logs out the user."""
    st.session_state["logged_in"] = False
    st.session_state["username"] = None
    st.rerun()


# ------------------------- Main Application -------------------------

def main_app():
    """Main application function after user logs in."""
    st.set_page_config(page_title="MediRank - Best Hospitals Finder", page_icon="🏥")
    st.title("🏥 MediRank - Best Hospitals Finder")
    st.write(f"Welcome, **{st.session_state['username']}**!")

    # Load models & encoders
    inpatient_model, outpatient_model = load_models()
    inpatient_le_drg, inpatient_le_state, outpatient_le_apc, outpatient_le_state = load_encoders()

    if None in (inpatient_model, outpatient_model, inpatient_le_drg, inpatient_le_state, outpatient_le_apc, outpatient_le_state):
        st.error("⚠️ Unable to load models or encoders. Please check the files and try again.")
        return

    # Sidebar Logout Button
    st.sidebar.button("🔓 Logout", on_click=logout)

    # Select Service Type
    service_type = st.selectbox("Select Service Type", ["Inpatient", "Outpatient"])

    if service_type == "Inpatient":
        procedure_options = inpatient_le_drg.classes_
        state_options = inpatient_le_state.classes_
    else:
        procedure_options = outpatient_le_apc.classes_
        state_options = outpatient_le_state.classes_

    # User selects procedure & state
    procedure = st.selectbox("Select Procedure", procedure_options)
    state = st.selectbox("Select State", state_options)

    # Dummy Provider IDs (Replace with real ones)
    provider_ids = list(range(520000, 520100))  # Ensure realistic provider IDs

    # Find Best Hospital Button
    if st.button("Find Best Hospitals"):
        try:
            # Encode Procedure and State
            if service_type == "Inpatient":
                encoded_procedure = inpatient_le_drg.transform([procedure])[0]
                encoded_state = inpatient_le_state.transform([state])[0]
                model = inpatient_model
            else:
                encoded_procedure = outpatient_le_apc.transform([procedure])[0]
                encoded_state = outpatient_le_state.transform([state])[0]
                model = outpatient_model

            # Generate input data for all provider IDs
            input_data = pd.DataFrame({
                "Procedure": [encoded_procedure] * len(provider_ids),
                "Provider_Id": provider_ids,
                "Provider_State": [encoded_state] * len(provider_ids),
                "Total_Discharge": [100] * len(provider_ids),
                "Avg_covered_charges": [15000] * len(provider_ids)
            })

            # Predict Costs
            input_data["Average_Total_Payments"] = model.predict(input_data)

            # Sort Providers by Cost (Ascending)
            input_data_sorted = input_data.sort_values(by="Average_Total_Payments", ascending=True).reset_index(drop=True)

            # Assign Rank (Starting from 1)
            input_data_sorted["Rank"] = input_data_sorted.index + 1

            # Get only the **Top 3 Hospitals**
            top_3_hospitals = input_data_sorted.head(3)[["Rank", "Provider_Id", "Average_Total_Payments"]]

            # Display Results
            st.write("### 🏆 Top 3 Best Hospitals (Lowest Cost First)")
            st.dataframe(top_3_hospitals)

        except Exception as e:
            st.error(f"⚠️ Error: {e}")

# ------------------------- Run Application -------------------------

# Initialize session state
initialize_session_state()

if not st.session_state["logged_in"]:
    login_page()
else:
    main_app()
