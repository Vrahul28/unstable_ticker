# 📈 Unstable Ticker

A Flutter app that listens to a WebSocket server and displays live stock ticker updates. The app handles **malformed JSON**, **anomalous price drops**, and **network failures** gracefully, with visual feedback and real-time updates.

---

## 🚀 Setup Instructions

1. Clone the Repository
git clone https://github.com/Vrahul28/unstable_ticker.git
cd unstable_ticker

2. Install Flutter Dependencies : flutter pub get

3. Run the WebSocket Server : dart mock_server.dart
   
4. Run the App : flutter run

5. Architectural Decisions
   
State Management:
Used GetX for its lightweight, reactive, and controller-based architecture.

Separation of Concerns:

WebSocketService handles data connection and reconnection logic

StockController manages business logic, including data validation and anomaly filtering

StockListScreen and StockTile handle UI rendering efficiently

Error Resilience:
Stream and controller-based design ensures errors in WebSocket parsing or logic don't crash the UI.

6.  Anomaly Detection Heuristic: A stock price is considered anomalous if it drops more than 80% compared to the last known valid price: 
    if (newPrice < lastPrice * 0.2) => mark as anomalous
    
Trade-offs:

✅ Catches unrealistic sudden crashes (e.g., 95% drop in 1s)
⚠️ May incorrectly flag real market crashes (false positives)
❌ Does not handle sharp increases (only drop detection was required)

7. Performance Analysis:

Optimization Techniques: 

Efficient List Updates: Only the StockTile widget gets rebuilt if its stock value changes.
No setState() used globally: All updates are reactive (Obx) for precise rebuilds.
Flash Color Efficiency: Animated color change uses AnimatedContainer for smooth transitions.

8. Flutter DevTools Overlay (Screenshot): Include a screenshot here named Screenshot 2025-06-30 130616.png next to README

