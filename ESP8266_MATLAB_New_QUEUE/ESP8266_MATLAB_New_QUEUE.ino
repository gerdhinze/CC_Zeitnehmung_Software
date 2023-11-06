const int queue_size = 10;
//Definition of the class
//########################################################################
class Queue {
private:
//    static const int MAX_SIZE = queue_size;
//    int elements[MAX_SIZE];
//    int front;
//    int rear;
//    int count;

public:
    static const int MAX_SIZE = queue_size;
    int elements[MAX_SIZE];
    int front;
    int rear;
    int count;
    
    Queue() {
        front = 0;
        rear = -1;
        count = 0;
    }
    bool isEmpty() {
        return count == 0;
    }
    bool isFull() {
        return count == MAX_SIZE;
    }
    void enqueue(int item) {
        if (isFull()) {
            // if queue is full, the last element is removed
            front = (front + 1) % MAX_SIZE;
            count--;
        }
        rear = (rear + 1) % MAX_SIZE;
        elements[rear] = item;
        count++;
    }
    int dequeue() {
        if (!isEmpty()) {
            int item = elements[front];
            front = (front + 1) % MAX_SIZE;
            count--;
            return item;
        } else {
            Serial.println("Queue is empty. Cannot dequeue.");
            return -1; 
        }
    }
    void printQueue() {
        Serial.print("Queue: ");
        for (int i = 0; i < count; i++) {
            int index = (front + i) % MAX_SIZE;
            Serial.print(elements[index]);
            Serial.print("..");
        }
        Serial.println();
    }
};
//#######################################################################
Queue myQueue;
int counter = 0;
int run = 0;
void setup() {
Serial.begin(115200);
}
void loop() {
    if (Serial.available() > 0) {
    String input = Serial.readStringUntil('\n'); // Lies die Eingabe bis zum Zeilenumbruch
    input.trim(); // Entferne Leerzeichen am Anfang und Ende
    
    if (input.equals("clear")) {
      // Lösche die bis dato gespeicherten Elemente in der Queue
      myQueue.count = 0;
      counter = 0;
      while (!myQueue.isEmpty()) {
      myQueue.dequeue();
      }
      Serial.println("Queue wurde geloescht.");
    }
    else if (input.equals("fill")) {
      // Fülle die Queue mit zufaelligen Zahlen
      run = true;
      Serial.println("Fuelle die Queue mit zufaelligen Zahlen.");
    }
    else if (input.equals("stop")) {
      // Stoppe das Fuellen der Queue
      run = false;
      Serial.println("Fuellen der Queue wurde gestoppt.");
    }
  }

  if (run) {
    // Füge kontinuierlich neue Elemente hinzu
    int newItem = random(9); // Zufallszahl zwischen 0 und 9
    myQueue.enqueue(newItem);

    Serial.print(counter);
    Serial.print(". --> ");
    myQueue.printQueue();

    delay(1000);

    if (counter < queue_size - 1) {
      counter++;
    } else {
      counter = 0;
    }
  }
}
