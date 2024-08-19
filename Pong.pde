float paddle1X;
float paddle1Y;
float paddle2X;
float paddle2Y;
float ballX;
float ballY;
boolean ballStationary = true;
int paddleSpeed = 5;
int ballSpeedX = 4;
int ballSpeedY = 6;
int scorePaddle1 = 0;
int scorePaddle2 = 0;

boolean upPressed = false;
boolean downPressed = false;
boolean wPressed = false;
boolean sPressed = false;

void setup(){
  size(720,480);
  textSize(30);
  paddle1X = 15;
  paddle1Y = height/2;
  paddle2X = width - 15;
  paddle2Y = height/2;
  resetBall();
}

void draw(){
  background(0);
  
  stroke(255);
  line(width/2, 0, width/2, height); // Screen Divider
  
  rectMode(CENTER);
  rect(paddle1X, paddle1Y, 10, 60); // Paddle 1
  rect(paddle2X, paddle2Y, 10, 60); // Paddle 2
  ellipse(ballX, ballY, 20, 20); // Ball
  
  movePaddles();
  moveBall();
  controlBall();
  displayScore();
}

void resetBall(){
  ballX = width/2;
  ballY = height/2;
  ballStationary = true;
}

void movePaddles(){
  if (wPressed && paddle1Y - 30 > 0) {
    paddle1Y -= paddleSpeed;
  }
  if (sPressed && paddle1Y + 30 < height) {
    paddle1Y += paddleSpeed;
  }
  if (upPressed && paddle2Y - 30 > 0) {
    paddle2Y -= paddleSpeed;
  }
  if (downPressed && paddle2Y + 30 < height) {
    paddle2Y += paddleSpeed;
  }
}

void moveBall(){
  if (!ballStationary) {
    ballX += ballSpeedX;
    ballY += ballSpeedY;
  } else if (keyPressed && key == ' ') {
    ballStationary = false;
  }
}

void controlBall(){
  // Bounce off top and bottom
  if (ballY + 10 > height || ballY - 10 < 0) {
    ballSpeedY = -ballSpeedY;
  }
  
  // Bounce off paddle 2
  if (ballY > paddle2Y - 30 && ballY < paddle2Y + 30 && ballX + 10 > paddle2X - 5) {
    if (ballSpeedX > 0) {
      ballSpeedX = -ballSpeedX;
    }
  }
  
  // Bounce off paddle 1
  if (ballY > paddle1Y - 30 && ballY < paddle1Y + 30 && ballX - 10 < paddle1X + 5) {
    if (ballSpeedX < 0) {
      ballSpeedX = -ballSpeedX;
    }
  }
}

void displayScore(){
  if (ballX - 10 > width) {
    scorePaddle1++;
    resetBall();
  } else if (ballX + 10 < 0) {
    scorePaddle2++;
    resetBall();
  }
  
  fill(255);
  text(scorePaddle1, width - width / 4, 50);
  text(scorePaddle2, width / 4, 50);
}

void keyPressed(){
  if (key == 'w') {
    wPressed = true;
  }
  if (key == 's') {
    sPressed = true;
  }
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
}

void keyReleased(){
  if (key == 'w') {
    wPressed = false;
  }
  if (key == 's') {
    sPressed = false;
  }
  if (keyCode == UP) {
    upPressed = false;
  }
  if (keyCode == DOWN) {
    downPressed = false;
  }
}
