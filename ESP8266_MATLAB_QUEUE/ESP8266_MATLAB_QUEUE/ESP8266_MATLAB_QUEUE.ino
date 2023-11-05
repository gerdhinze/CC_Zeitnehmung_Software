const int queue_size = 10;
//Definition of the class
//########################################################################
class Queue {
private:
    static const int MAX_SIZE = queue_size;
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
int count = 0;
void setup() {
    Serial.begin(115200);
}
void loop() {
    // A new items is added continuously
    int newItem = random(9); // Random number between 0 and 9
    myQueue.enqueue(newItem);

    Serial.print(count);
    Serial.print(". --> ");
    // Output of the queue in serial monitor
    myQueue.printQueue();

    delay(1000);

    if(count < queue_size-1){
      count ++;
    }
    else{
      count = 0;
    }
}
