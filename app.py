import streamlit as st
import requests
import base64

# Título principal
st.markdown("<h1 style='text-align: center;'>🤖 ChatBali: Consulta tu Contrato Hospital Concesionario</h1>", unsafe_allow_html=True)

# --- Visualización del PDF ---
st.markdown("### 📄 Documento")

pdf_path = "contrato.pdf"

# Mostrar PDF incrustado si existe
try:
    with open(pdf_path, "rb") as f:
        base64_pdf = base64.b64encode(f.read()).decode("utf-8")
        pdf_display = f'<iframe src="data:application/pdf;base64,{base64_pdf}" width="100%" height="600px" type="application/pdf"></iframe>'
        st.markdown(pdf_display, unsafe_allow_html=True)

        # También opción de descarga
        f.seek(0)
        st.download_button("📥 Descargar PDF", f, file_name="ContratoHospital.pdf")
except FileNotFoundError:
    st.warning("⚠️ El archivo PDF no se encontró. Asegúrate de que esté en la raíz del proyecto con el nombre correcto.")

# --- Chat con ChatPDF ---
st.markdown("### 💬 Haz tu pregunta")

API_KEY = st.secrets["CHATPDF_API_KEY"]
SOURCE_ID = "cha_G85wPwqQ0gYG0SodoZPlh"  # Reemplaza con tu ID si cambia

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

