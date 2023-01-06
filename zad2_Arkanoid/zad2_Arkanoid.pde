int platformX; // pozycja platformy w osi X
int platformY; // pozycja platformy w osi Y
int platformW; // szerokość platformy
int platformH; // wysokość platformy
int platformSpeed; // szybkość platformy

int ballX; // pozycja dysku w osi X
int ballY; // pozycja dysku w osi Y
int ballD; // średnica dysku
int ballVX; // prędkość dysku w osi X
int ballVY; // prędkość dysku w osi Y

int brickRows; // liczba wierszy klocków
int brickColumns; // liczba kolumn klocków
int brickW; // szerokość klocków
int brickH; // wysokość klocków
int brickGap; // odstęp między klockami
int brickTop; // odległość klocków od górnej krawędzi ekranu
int[][] bricks; // tablica przechowująca informacje o klockach

void setup() {
  size(400, 600);
  platformX = width / 2;
  platformY = height - 50;
  platformW = 100;
  platformH = 20;
  platformSpeed = 8;
  ballX = width / 2;
  ballY = height / 2;
  ballD = 20;
  ballVX = 3;
  ballVY = -3;
  brickRows = 3;
  brickColumns = 7;
  brickW = 50;
  brickH = 20;
  brickGap = 5;
  brickTop = 50;
  bricks = new int[brickRows][brickColumns];
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickColumns; j++) {
      bricks[i][j] = 1; // wszystkie klocki są widoczne na początku
    }
  }
}

void draw() {
  background(200);
  rect(platformX, platformY, platformW, platformH);
  ellipse(ballX, ballY, ballD, ballD);
  for (int i = 0; i < brickRows; i++) {
    for (int j = 0; j < brickColumns; j++) {
      if (bricks[i][j] == 1) {
        rect(j * (brickW + brickGap), i * (brickH + brickGap) + brickTop, brickW, brickH);
      }
    }
  }
  // obsługa ruchu platformy
  if (keyPressed && keyCode ==RIGHT) {
platformX += platformSpeed;
} else if (keyPressed && keyCode == LEFT) {
platformX -= platformSpeed;
}
// ograniczenie ruchu platformy do obszaru gry
platformX = constrain(platformX, 0, width - platformW);
// obsługa ruchu dysku
ballX += ballVX;
ballY += ballVY;
// odbijanie dysku od krawędzi ekranu
if (ballX < 0 || ballX > width) {
ballVX *= -1;
}
if (ballY < 0) {
ballVY *= -1;
}
// sprawdzenie, czy dysk dotknął platformy
if (ballY + ballD/2 > platformY && ballX > platformX && ballX < platformX + platformW) {
ballVY *= -1;
}
// sprawdzenie, czy dysk trafił w klocek
for (int i = 0; i < brickRows; i++) {
for (int j = 0; j < brickColumns; j++) {
if (bricks[i][j] == 1) {
if (ballX > j * (brickW + brickGap) && ballX < (j+1) * (brickW + brickGap) && ballY + ballD/2 < i * (brickH + brickGap) + brickTop) {
ballVY *= -1;
bricks[i][j] = 0;
}
}
}
}
// sprawdzenie, czy gracz wygrał lub przegrał
if (ballY > height) {
fill(255, 0, 0);
textSize(32);
textAlign(CENTER);
text("Przegrałeś!", width/2, height/2);

} else {
boolean won = true;
for (int i = 0; i < brickRows; i++) {
for (int j = 0; j < brickColumns; j++) {
if (bricks[i][j] == 1) {
won = false;
break;
}
}
if (!won) {
break;
}
}
if (won) {
fill(0, 255, 0);
textSize(32);
textAlign(CENTER);
text("Wygrałeś!", width/2, height/2);
}
}
}
