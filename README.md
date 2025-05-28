# **Weather-Based Music Recommendation System**

## **Project Overview**
This project is a **weather-based music recommendation system** that suggests songs based on the current weather condition in a given city. The system uses the **WeatherAPI** to retrieve real-time weather data, analyzes the weather, temperature, and time of day, and then predicts a mood (e.g., energetic, relaxed, calm, etc.). Based on the predicted mood, the system queries a database (`Spotify.db`) of song data to recommend a list of songs with the corresponding mood and energy levels.

---

## **How to Run the Project**

### **Step 1: Obtain an API Key**
To access the weather data, you need a valid API key from **WeatherAPI**. Follow these steps:

1. Go to [WeatherAPI](https://www.weatherapi.com/) and create a free account.
2. Once logged in, navigate to the **API key** section and copy your unique API key.

### **Step 2: Set Your API Key in the Code**
1. In the `weather_music_recommender.ipynb` notebook, find the following line:
   ```python
   API_KEY = "your_api_key_here"



## **Project Structure**

The project includes the following files:
- `weather_music_recommender.ipynb`: The Jupyter notebook containing the code for weather data retrieval, mood prediction, and music recommendation.
- `Spotify.db`: A SQLite database containing song data, including tracks with information about valence and energy.


## **Important Notes**
- The project relies on the WeatherAPI to get weather data for mood prediction. You need to use your own API key as explained in Step 2.
- Ensure that the `Spotify.db` database is available and contains the required song data (the project assumes this database structure).




## **Key Features**
- **Weather Data Integration**: The system fetches real-time weather data based on a specified city using the WeatherAPI.
- **Mood Prediction**: It predicts the user's mood based on current weather conditions (e.g., sunny, rainy) and time of day (morning, daytime, night).
- **Song Recommendation**: Based on the predicted mood, the system recommends a list of songs by querying a database of songs and filtering them by mood-related parameters such as valence and energy.
- **Dynamic Song Selection**: Each time the code runs, it fetches a fresh set of 5 songs that match the predicted mood's characteristics.
- **SQLite Database**: Uses SQLite to store and query weather data and song details. It also uses a database to store mood predictions, which are then linked to the recommended songs.
- **Customizable**: Users can easily modify the weather condition-to-mood mapping or song recommendation criteria.


## **Key Skills & Technologies Used**
- **WeatherAPI**: For retrieving real-time weather data.
- **SQLite**: To store and query song data based on mood and energy.
- **Python**: The core programming language used for the system, with libraries like `requests` and `sqlite3`.
- **Mood Prediction**: A simple mapping of weather conditions to moods, along with a mapping of mood to song characteristics (valence and energy).
- **DB Browser for SQLite**: Used for querying, exploring, cleaning, and analyzing the song data stored in the SQLite database.
