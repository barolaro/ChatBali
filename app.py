import streamlit as st
import requests

st.set_page_config(layout="wide")  # Aprovecha el ancho completo

st.title("🤖 ChatBali: Consulta tu Contrato Hospital Concesionario")

API_KEY = st.secrets["CHATPDF_API_KEY"]
SOURCE_ID = "cha_G85wPwqQ0gYG0SodoZPlh"  # Reemplaza por tu ID si cambia

col1, col2 = st.columns([1, 2])

# 👉 Lado izquierdo: Visor del PDF
with col1:
    st.subheader("📄 Documento")
    pdf_url = "https://www.chatpdf.com/pdf/G85wPwqQ0gYG0SodoZPlh"  # URL pública del PDF
    st.markdown(f"""
        <iframe src="{pdf_url}" width="100%" height="700px" frameborder="0"></iframe>
    """, unsafe_allow_html=True)

# 👉 Lado derecho: Chat interactivo
with col2:
    st.subheader("💬 Haz tu pregunta")

    user_input = st.chat_input("Escribe tu duda sobre el contrato...")
    if user_input:
        with st.spinner("Consultando..."):
            headers = {
                "x-api-key": API_KEY,
                "Content-Type": "application/json"
            }

            data = {
                "sourceId": SOURCE_ID,
                "messages": [
                    {"role": "user", "content": user_input}
                ]
            }

            response = requests.post("https://api.chatpdf.com/v1/chats/message", json=data, headers=headers)

            if response.status_code == 200:
                result = response.json()
                st.markdown(result["content"])
            else:
                st.error("❌ Error al consultar la API de ChatPDF.")

