package com.grownited.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class GeocodingService {

    private static final String API_KEY = "AIzaSyDZaqhyWIWsB1uVgd-5aSs6WMIB8XwGkFU";  // Replace with your actual API key

    public static Double[] getLatLongFromAddress(String address) {
        try {
            if (address == null || address.trim().isEmpty()) {
                System.err.println("Invalid address provided!");
                return new Double[]{0.0, 0.0}; // Default fallback
            }

            String encodedAddress = URLEncoder.encode(address, "UTF-8");
            String urlStr = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodedAddress + "&key=" + API_KEY;

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            JSONObject jsonResponse = new JSONObject(response.toString());
            if (jsonResponse.getString("status").equals("OK")) {
                JSONArray results = jsonResponse.getJSONArray("results");
                JSONObject location = results.getJSONObject(0).getJSONObject("geometry").getJSONObject("location");

                Double lat = location.getDouble("lat");
                Double lon = location.getDouble("lng");

                return new Double[]{lat, lon};  // Returns latitude and longitude
            } else {
                System.err.println("No results found for address: " + address);
            }

        } catch (Exception e) {
            System.err.println("Geocoding API request failed: " + e.getMessage());
        }

        return new Double[]{0.0, 0.0}; // Default coordinates (fallback)
    }

    public static void main(String[] args) {
        Double[] points = GeocodingService.getLatLongFromAddress("b/3 nirnaynagar,sector vii");
        if (points != null) {
            System.out.println("Latitude: " + points[0]);
            System.out.println("Longitude: " + points[1]);
        } else {
            System.out.println("Failed to retrieve coordinates.");
        }
    }
}
