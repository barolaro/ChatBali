import streamlit as st
import requests

st.title("🤖 Chat con tu PDF usando ChatPDF")

API_KEY = st.secrets["CHATPDF_API_KEY"]
SOURCE_ID = "cha_G85wPwqQ0gYG0SodoZPlh"  # Tu source ID de ChatPDF

# Chat UI
user_input = st.chat_input("Haz una pregunta sobre el PDF")
if user_input:
    with st.spinner("Consultando..."):
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
            st.error("Error en la API")
