import streamlit as st
import requests

# --- Logo institucional ---
st.image("logo.png", width=100)  # Asegúrate de tener 'logo.png' en la misma carpeta que app.py

# --- Título principal ---
st.markdown("<h1 style='text-align: center;'>🤖 ChatBali: Explora las Bases de Licitación de tu Contrato Hospitalario</h1>", unsafe_allow_html=True)

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

# Mensaje fijo de bienvenida
with st.chat_message("assistant"):
    st.markdown("""
**¡Bienvenido al PDF de Bases de Licitación para Concesiones de Establecimientos de Salud!**

En este documento encontrarás toda la información necesaria para presentar una oferta exitosa y llevar a cabo la construcción y operación de un establecimiento de salud.

**Ejemplos de preguntas que puedes hacer:**
- ¿Cuáles son los requisitos mínimos que se deben cumplir en el Proyecto Definitivo?
- ¿Qué tipo de mobiliario y equipamiento debe proveer e instalar el Concesionario?
- ¿Cuál es el plazo establecido para presentar el Proyecto Definitivo correspondiente?
    """)

# --- Parámetros de API ChatPDF ---
API_KEY = st.secrets["CHATPDF_API_KEY"]
SOURCE_ID = "cha_G85wPwqQ0gYG0SodoZPlh"  # ID del PDF cargado en ChatPDF

# Entrada del usuario
user_input = st.chat_input("Escribe tu duda sobre el contrato...")

if user_input:
    with st.chat_message("user"):
        st.markdown(user_input)

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
            with st.chat_message("assistant"):
                st.markdown(result["content"])
        else:
            st.error("❌ Error en la API. Verifica tu clave o sourceId.")


