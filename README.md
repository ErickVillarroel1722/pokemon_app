# App Anime Entretaiment
**(Esta app sigue en proceso de mejora y desarrollo constante!)**
(Autor: Erick Villarroel)

Bienvenido a **Anime Entretaiment**, una aplicación móvil que te permite explorar tanto el mundo de los **Pokémon** como el de los **Anime**. A través de una interfaz sencilla y fácil de usar, puedes obtener detalles sobre tus Pokémon favoritos y explorar recomendaciones de anime.

**Actualizacion**
**(COMBATE:22 de Diciembre: Ahora podras disfrutar con el modo combate y tendras acceso a una pagina de peleas pokemon!!)**
**(Videos: 21 de Diciembre: Ahora tu anime favorito tiene su trailer en Youtube!!! Podras ver un mini resumen si no te gusta leer la sinopsis!!!)**

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework para construir aplicaciones móviles.
- **Dart**: Lenguaje de programación utilizado para el desarrollo.
- **API Pokémon**: Para obtener información sobre los Pokémon: https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0
- **API de Anime**: Para obtener recomendaciones de anime y detalles sobre series y películas: https://api.jikan.moe/v4/anime

## 📱 Funcionalidades
# Pokeanime App

Una aplicación que combina el mundo de Pokémon y Anime, permitiendo explorar contenido de ambas categorías de una forma interactiva.

---

### **Pokémon Screen**
- **Funcionalidades:**
  - Búsqueda por nombre de Pokémon.
  - Visualización de estadísticas y detalles relevantes de cada Pokémon.

| Antes de la Actualización                           | Después de la Actualización                            |
|-----------------------------------------------------|-------------------------------------------------------|
| <img src="https://github.com/user-attachments/assets/1e0300cf-375b-4955-b0a5-f49f94480ad2" width="300" /> | <img src="https://github.com/user-attachments/assets/ce3b0c80-7c23-4eac-860c-75876f202c38" width="300" /> |

---

### **Anime Screen**
- **Funcionalidades:**
  - Recomendaciones de anime con detalles como nombre, género y una breve descripción.
  - Interfaz amigable para explorar y aprender más sobre anime.

| Antes de la Actualización                           | Después de la Actualización                            |
|-----------------------------------------------------|-------------------------------------------------------|
| <img src="https://github.com/user-attachments/assets/6f8f612d-88b8-4aae-934b-5c31dfdc7b71" width="300" /> | <img src="https://github.com/user-attachments/assets/39b91d40-549f-4bbc-90f8-58fc09dad381" width="300" /> |

---

### **Pantalla de Anime Detallado**
- **Funcionalidades:**
  - Visualización detallada de una serie o película seleccionada.

| Antes de la Actualización                           | Después de la Actualización                            |
|-----------------------------------------------------|-------------------------------------------------------|
| <img src="https://github.com/user-attachments/assets/61f7d46b-72b3-4e8f-b364-4113fbf19523" width="300" /> | <img src="https://github.com/user-attachments/assets/c61ccb25-ebce-4dca-8aa3-f00f4f5f0c60" width="300" /> |


## 🚀 Proceso de Desarrollo

1. **Inicio del Proyecto**: Creamos un nuevo proyecto Flutter y estructuramos la aplicación para dos funcionalidades principales: Pokémon y Anime.
2. **Integración de APIs**:
   - **API Pokémon**: Se utilizó una API gratuita para obtener los datos de Pokémon y presentarlos de manera interactiva en la pantalla.
   - **API Anime**: Se integró una API pública para obtener recomendaciones y detalles sobre animes populares.
3. **Interfaz de Usuario**:
   - El diseño se centró en ofrecer una experiencia limpia, con colores vivos y una estructura clara.
   - Añadimos una barra de navegación que permite al usuario navegar entre las secciones de Pokémon y Anime con facilidad.
   - Utilizamos iconos personalizados y texto descriptivo para mejorar la accesibilidad.

4. **Generación del APK**:
   - Después de completar el desarrollo, se generó el archivo APK para pruebas en dispositivos Android.
   - Se utilizó el comando `flutter build apk --release` para la compilación y optimización del archivo.

## ⚡ Cómo Ejecutar la App

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/ErickVillarroel1722/pokemon_app 

2. **Instalar dependencias**:
    Para instalar las dependencias del proyecto, abre una terminal en el directorio del proyecto y ejecuta el siguiente comando:
    ```bash
    flutter pub get
    ```

3. **Ejecutar en un emulador o dispositivo conectado**:
    Asegúrate de tener un emulador o dispositivo conectado, luego ejecuta:
    ```bash
    flutter run
    ```

4. **Generar APK (Opcional)**:
    Para generar el archivo APK y probar en tu dispositivo, usa el siguiente comando:
    ```bash
    flutter build apk --release
    ```
