import streamlit as st
import numpy as np
import pickle
import base64

# ---------------- PAGE CONFIG ----------------
st.set_page_config(
    page_title="Customer Churn Prediction",
    page_icon="📉",
    layout="centered"
)

# ---------------- BACKGROUND VIDEO FUNCTION ----------------
def get_video_base64(video_path):
    with open(video_path, "rb") as video_file:
        return base64.b64encode(video_file.read()).decode()

# ---------------- LOAD BACKGROUND VIDEO ----------------
video_base64 = get_video_base64("background.mp4")

st.markdown(
    f"""
    <style>
    .stApp {{
        background: none;
    }}

    .video-background {{
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
        z-index: -1;
        object-fit: cover;
    }}
    </style>

    <video autoplay loop muted class="video-background">
        <source src="data:video/mp4;base64,{video_base64}" type="video/mp4">
    </video>
    """,
    unsafe_allow_html=True
)

# ---------------- LOAD MODEL & SCALER ----------------
with open("churn_random_forest_model.pkl", "rb") as file:
    model = pickle.load(file)

with open("scaler.pkl", "rb") as file:
    scaler = pickle.load(file)

# ---------------- UI CARD START ----------------
st.markdown(
    """
    <div style="
        background-color: rgba(0, 0, 0, 0.65);
        padding: 30px;
        border-radius: 16px;
        color: white;
        max-width: 650px;
        margin: auto;
    ">
    """,
    unsafe_allow_html=True
)

st.title("🔮 Customer Churn Prediction")
st.write("Fill the customer details below to predict churn")

# ---------------- INPUT FIELDS ----------------
credit_score = st.number_input("Credit Score", 300, 900, 600)
gender = st.selectbox("Gender", ["Male", "Female"])
age = st.number_input("Age", 18, 100, 35)
tenure = st.number_input("Tenure (Years)", 0, 10, 3)
balance = st.number_input("Account Balance", 0.0, 300000.0, 50000.0)
num_products = st.number_input("Number of Products", 1, 4, 1)
has_card = st.selectbox("Has Credit Card?", ["Yes", "No"])
is_active = st.selectbox("Is Active Member?", ["Yes", "No"])
salary = st.number_input("Estimated Salary", 0.0, 200000.0, 50000.0)
country = st.selectbox("Country", ["France", "Germany", "Spain"])

# ---------------- ENCODING ----------------
gender = 1 if gender == "Male" else 0
has_card = 1 if has_card == "Yes" else 0
is_active = 1 if is_active == "Yes" else 0

geo_germany = 1 if country == "Germany" else 0
geo_spain = 1 if country == "Spain" else 0

# ---------------- PREDICTION ----------------
if st.button("🔍 Predict Churn"):
    input_data = np.array([[credit_score, gender, age, tenure, balance,
                             num_products, has_card, is_active, salary,
                             geo_germany, geo_spain]])

    input_scaled = scaler.transform(input_data)
    prediction = model.predict(input_scaled)

    if prediction[0] == 1:
        st.error("⚠️ Customer is likely to CHURN")
    else:
        st.success("✅ Customer is likely to STAY")

# ---------------- UI CARD END ----------------
st.markdown("</div>", unsafe_allow_html=True)
