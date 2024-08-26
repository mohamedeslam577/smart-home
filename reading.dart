import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:test2/control.dart';
import 'package:test2/homepage.dart';

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  _ReadingState createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  late MqttServerClient client;
  String broker =
      'd13b8e3fb5d74ecd827e8cfde4ace40f.s1.eu.hivemq.cloud'; // Replace with your broker URL
  String topicFlame =
      'flame/sensor'; // Replace with your topic for flame sensor
  String topicMotion =
      'pir/sensor'; // Replace with your topic for motion sensor
  String topicGas = 'gas/sensor'; // Replace with your topic for gas sensor
  String topicTemp =
      'temp/sensor'; // Replace with your topic for temperature sensor
  String topicHumidity =
      'humidity/sensor'; // Replace with your topic for humidity sensor
  int port = 8883; // Use 8883 for secure MQTT (TLS/SSL) or 1883 for non-secure
  String username = 'smarthome/project'; // Optional
  String password = 'Fcdssmarthome777'; // Optional

  String flameSensorData = "Waiting for data...";
  String motionSensorData = "Waiting for data...";
  String gasSensorData = "Waiting for data...";
  String temperatureSensorData = "Waiting for data...";
  String humiditySensorData = "Waiting for data...";

  @override
  void initState() {
    super.initState();
    _connect();
  }

  Future<void> _connect() async {
    client = MqttServerClient(broker, '');
    client.port = port;
    client.secure = true; // Set to false if not using SSL/TLS
    client.keepAlivePeriod = 20;

    final context = SecurityContext.defaultContext;
    client.securityContext = context;

    client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.onUnsubscribed = onUnsubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client') // Replace with your client ID
        .authenticateAs(
            username, password) // Use if your broker requires authentication
        .startClean() // Non-persistent session for simplicity
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      print('Error: $e');
      client.disconnect();
      return; // Prevents proceeding if connection fails
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String topic = c[0].topic;

      setState(() {
        if (topic == topicFlame) {
          flameSensorData = message;
        } else if (topic == topicMotion) {
          motionSensorData = message;
        } else if (topic == topicGas) {
          gasSensorData = message;
        } else if (topic == topicTemp) {
          temperatureSensorData = message;
        } else if (topic == topicHumidity) {
          humiditySensorData = message;
        }
      });

      print('Received message: $message from topic: ${c[0].topic}>');
    });
  }

  void onConnected() {
    print('Connected to broker');
    client.subscribe(topicFlame, MqttQos.atMostOnce);
    client.subscribe(topicMotion, MqttQos.atMostOnce);
    client.subscribe(topicGas, MqttQos.atMostOnce);
    client.subscribe(topicTemp, MqttQos.atMostOnce);
    client.subscribe(topicHumidity, MqttQos.atMostOnce);
  }

  void onDisconnected() {
    print('Disconnected from broker');
  }

  void onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }

  void onSubscribeFail(String topic) {
    print('Failed to subscribe to topic: $topic');
  }

  void onUnsubscribed(String? topic) {
    print('Unsubscribed from topic: $topic');
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home App"),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.cyan[400]),
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://img.pikbest.com/backgrounds/20220119/smart-home-house-blue-technology-poster_6244629.jpg!sw800",
              ),
              fit: BoxFit.fill,
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "The readings of the sensors",
                style: TextStyle(
                  fontSize: 30,
                  color: const Color.fromARGB(255, 235, 232, 227),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildSensorDataContainer("Flame Sensor", flameSensorData),
              SizedBox(height: 20),
              _buildSensorDataContainer("Motion Sensor", motionSensorData),
              SizedBox(height: 20),
              _buildSensorDataContainer("Gas Sensor", gasSensorData),
              SizedBox(height: 20),
              _buildSensorDataContainer(
                  "Temperature Sensor", temperatureSensorData),
              SizedBox(height: 20),
              _buildSensorDataContainer("Humidity Sensor", humiditySensorData),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Control()));

                    },
                    height: 75,
                    minWidth: 200,
                    color: Colors.black54,
                    textColor: Colors.cyan[400],
                    child: Text("Go to the control room"),
                  ),
                  MaterialButton(
                    onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()));

                    },
                    height: 75,
                    minWidth: 200,
                    color: Colors.black54,
                    textColor: Colors.cyan[400],
                    child: Text("Back To Homepage"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorDataContainer(String sensorName, String sensorData) {
    return Container(
      width: double.infinity,
      height: 140,
      color: Colors.black54.withOpacity(0.5),
      padding: EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "$sensorName: $sensorData",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}