# Pokeanime App

Bienvenido a **Pokeanime App**, una aplicación móvil que te permite explorar tanto el mundo de los **Pokémon** como el de los **Anime**. A través de una interfaz sencilla y fácil de usar, puedes obtener detalles sobre tus Pokémon favoritos y explorar recomendaciones de anime.

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework para construir aplicaciones móviles.
- **Dart**: Lenguaje de programación utilizado para el desarrollo.
- **API Pokémon**: Para obtener información sobre los Pokémon:https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0 
- **API de Anime**: Para obtener recomendaciones de anime y detalles sobre series y películas:https://api.jikan.moe/v4/anime

## 📱 Funcionalidades

### Pokémon Screen:
- Búsqueda por nombre de Pokémon.
- Muestra estadísticas y detalles relevantes de cada Pokémon.

### Anime Screen:
- Recomendaciones de anime con detalles como nombre, género, y una breve descripción.
- Interfaz amigable para explorar y aprender más sobre anime.

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

## 📸 Capturas de Pantalla

Aquí tienes algunas capturas de la aplicación en ejecución:

### Pantalla de Pokémon
![Pantalla Pokémon](![{1742F844-9CB8-4CB5-9832-57BF2FBFD494}](https://github.com/user-attachments/assets/e722ce13-9fb0-4419-b8b5-77ec8e7ddc79)
)

### Pantalla de Anime
![Pantalla Anime](![{49F169DC-ECEA-435F-8C9B-58F7F4CF0C06}](https://github.com/user-attachments/assets/f1459c62-3635-4e19-95da-e761f3d9f8fc)
)


![Detalle del anime](![{11F60469-2072-4714-B22D-9C5A06418F0C}](https://github.com/user-attachments/assets/b0126780-6a25-42aa-84a5-9ef4502f0469)

)

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
