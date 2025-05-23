import streamlit as st
import requests

# --- Título principal ---
st.markdown("<h1 style='text-align: center;'>🤖 ChatBali: Consulta tu Contrato Hospital Concesionario</h1>", unsafe_allow_html=True)

# --- Botón para descargar el PDF ---
st.markdown("### 📄 Descarga del documento")

pdf_path = "contrato.pdf"
try:
    with open(pdf_path, "rb") as f:
        st.download_button("📥 Descargar contrato.pdf", f, file_name="contrato.pdf", mime="application/pdf")
except FileNotFoundError:
    st.warning("⚠️ El archivo contrato.pdf no se encontró. Asegúrate de que esté en la raíz del proyecto.")

# --- Chat con ChatPDF ---
st.markdown("### 💬 Haz tu pregunta")

API_KEY = st.secrets["CHATPDF_API_KEY"]
SOURCE_ID = "cha_G85wPwqQ0gYG0SodoZPlh"  # Tu ID de ChatPDF

user_input = st.chat_input("Escribe tu duda sobre el contrato...")

if user_input:
    with st.spinner("Consultando ChatPDF..."):
        headers = {
            "x-api-key": API_KEY,
            "Content-Type": "application/json"
        }

        data = {
            "sourceId": SOURCE_ID,
            "messages": [
                { "role": "user", "content": user_input }
            ]
        }

        response = requests.post("https://api.chatpdf.com/v1/chats/message", json=data, headers=headers)

        if response.status_code == 200:
            result = response.json()
            st.markdown(result["content"])
        else:
            st.error("❌ Error en la API. Verifica tu clave o sourceId.")

