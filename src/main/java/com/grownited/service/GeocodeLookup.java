package com.grownited.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class GeocodeLookup {
    public static void main(String[] args) {
        String address = "New York, USA"; // Change this to any address
        getLatLongFromAddress(address);
    }

    public static void getLatLongFromAddress(String address) {
        try {
            // Replace spaces with "+" for URL encoding
            String formattedAddress = address.replace(" ", "+");
            String urlString = "https://nominatim.openstreetmap.org/search?format=json&q=" + formattedAddress;

            // Make HTTP request
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0"); // Required for some APIs

            // Read response
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Parse JSON response
            JSONArray jsonArray = new JSONArray(response.toString());
            if (jsonArray.length() > 0) {
                JSONObject location = jsonArray.getJSONObject(0);
                String latitude = location.getString("lat");
                String longitude = location.getString("lon");
                System.out.println("Latitude: " + latitude + ", Longitude: " + longitude);
            } else {
                System.out.println("No results found for the address.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
