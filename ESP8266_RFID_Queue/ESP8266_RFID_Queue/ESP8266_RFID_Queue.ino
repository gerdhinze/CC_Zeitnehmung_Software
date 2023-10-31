
class Queue {
private:
    static const int MAX_SIZE = 10;
    int elements[MAX_SIZE];
    int front;
    int rear;
    int count;

public:
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
            // Wenn die Queue voll ist, entfernen Sie das älteste Element (vorderstes Element).
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
            return -1; // You can return a special value to indicate an empty queue
        }
    }

    void printQueue() {
        Serial.print("Queue: ");
        for (int i = 0; i < count; i++) {
            int index = (front + i) % MAX_SIZE;
            Serial.print(elements[index]);
            Serial.print(" ");
        }
        Serial.println();
    }
};

Queue myQueue;

void setup() {
    Serial.begin(115200);
}

void loop() {
    // Fügen Sie ständig neue Elemente zur Queue hinzu
    int newItem = random(9); // Beispiel: Zufällige Zahl zwischen 0 und 99
    myQueue.enqueue(newItem);

    // Ausgabe der Queue-Elemente am Serial Monitor
    myQueue.printQueue();

    delay(1000); // Warten Sie für eine Sekunde, bevor Sie ein neues Element hinzufügen
}
