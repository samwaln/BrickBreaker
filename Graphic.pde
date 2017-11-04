boolean[][] blocks = new boolean[15][5];
int ballX;
int ballY;
int ballDirection;
int paddleX;
int paddleY;
boolean gameStarted;

long timestarted;
long timeelapsed;

void setup(){
  size(600,400);
  background(50,50,50);
  timestarted = System.currentTimeMillis();
  for (int i = 0; i < blocks.length; i++){
    for (int j = 0; j < blocks[0].length; j++){
      blocks[i][j] = true;
    }
  }
  ballX = 295;
  ballY = 370;
  ballDirection = 45;
  paddleX = 275;
  paddleY = 375;
  gameStarted = false;
}

void playGame(){
  if (gameStarted){
    if (ballDirection > 0){
      ballY -= 3;
      ballX -= int(0.1*Math.abs(45 - Math.abs(ballDirection)));
      if (hitBlock() || ballY < 0){
        ballDirection = -1 * ballDirection;
      }
      if (ballX + 10 > width){
        ballDirection = Math.abs(90 - ballDirection);
      }
      else if (ballX < 0){
        ballDirection = 90 + ballDirection;
      }
    }
    else{
      ballY += 3;
      ballX -= int(0.1*Math.abs(45 - Math.abs(ballDirection)));
      if (hitPaddle()){
        ballDirection = -1 * ballDirection;
      }
      if (ballY + 5 > height){
        gameStarted = false;
      }
      if (ballX + 10 > width){
        ballDirection = Math.abs(90 - ballDirection);
      }
      else if (ballX < 0){
        gameStarted = false;
        ballDirection = 90 + ballDirection;
      }
    }
  }
}

boolean hitBlock(){
  return false;
}

boolean hitPaddle(){
  if (ballY + 5 > paddleY  && ballY + 5 < paddleY + 5){
    if (ballX + 5 > paddleX && ballX + 5 < paddleX + 40){
      if (ballX + 5 < paddleX + 15){
        ballDirection -= 10;
      }
      if (ballX + 5 > paddleX + 25){
        ballDirection += 10;
      }
      return true;
    }
  }
  return false;
}

void space(){
  gameStarted = !gameStarted;
}

void right(){
  if (gameStarted){
    paddleX += 15;
  }
  if (paddleX > width - 40){
    paddleX = width - 40;
  }
}

void left(){
  if (gameStarted) {
    paddleX -= 15;
  }
  if (paddleX < 0){
    paddleX = 0;
  }
}

void keyPressed(){
  if (key==' '){
    space();
  }
  else if (keyCode==RIGHT){
    right();
  }
  else if (keyCode==LEFT){
    left();
  }
  redraw();
}

void draw(){
  background(50,50,50);
  playGame();
  for (int i = 0; i<blocks.length; i++){
    for (int j = 0; j<blocks[0].length; j++){
      if (i % 2 == 1 && j % 2 == 0){
        fill(255,0,0);
      }
      else if (i % 2 == 0 && j % 2 == 1){
        fill(255,0,0);
      }
      else {
        fill(255,200,0);
      }
      if (blocks[i][j]){
        rect(i*40,j*20,40,20);
      }
    }
  }
  fill(255,255,255);
  ellipse(ballX, ballY, 10, 10);
  fill(200,200,200);
  rect(paddleX, paddleY, 40, 10);
}