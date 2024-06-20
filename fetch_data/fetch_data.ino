#include <WiFi.h>
#include <WebServer.h>
#include <ArduinoJson.h>

// Replace with your network credentials
const char* ssid = "SSID";
const char* password = "123456789";

#define sensor A0
int An_1;

WebServer server(80);

void handleData();

String readDSTemperatureC() {
  An_1 = analogRead(sensor);
  float voltage= An_1 * (3.3/4095.0);
  int tempC = (voltage - 0.58)/0.007;
  return String(tempC);
}

void setup() {
  Serial.begin(115200);
  Serial.print("Connecting to WiFi");
  WiFi.softAP(ssid, password);
    Serial.println("Hotspot WiFi démarré");
    Serial.print("IP Address: ");
    Serial.println(WiFi.softAPIP());

  server.on("/data", HTTP_GET, handleData);

  server.begin();
  Serial.println("Server started");
}

void loop() {
  server.handleClient();
}

void handleData() {
  StaticJsonDocument<200> jsonDoc;
  jsonDoc["temperature"] = readDSTemperatureC();
  String jsonString;
  serializeJson(jsonDoc, jsonString);
  server.sendHeader("Content-Type", "application/json");
  server.send(200, "application/json", jsonString);
}