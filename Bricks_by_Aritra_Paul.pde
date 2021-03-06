////Enhancements////
///    1. New level, after user hits all the bricks in the game, a new level starts and speedX and speedY get multiplied by 1.5
///    2. High Score saves itself and displays
//     3. Game restarts itself everytime a player runs out of lives.
//     4. Game restarts if user reaches level 20 which also means that, the player has won.
//    
//     Ability to earn bonus points by bricks appearing randomly when score%500 == 0 is a work in progress (Line 273 - Line 335)



int m = 5;
int h = 100/m;
int n = 10;
int w = 400/n; 

//int[][]box = new int[n][m];


//High Score keepers

int highscoregetter = 0;
int highscore = 0;


//other stuff  
float gameover = 0;
float winner = 0;
boolean[][] check = new boolean[n][m];
float gamerestartingrect = 0;
int timer1 = 0;
int timer2 = 0;
float textsize = 40;
int level = 1;
float yOFrect = 360;
float rectw = 50;
float mouseXchecker = 0;
float y = 345.0;
float recth = 15;
float runBallx = mouseX + rectw/2;
float runBallxINITIAL = runBallx;
boolean mouseclick = false;
float speedX=-2.0;
float speedY=5.0;
int livesChecker = 0;
float xOfBoxes = 0;
float yOfBoxes = 0;
int cornerDirection = 0; 
float speedXLocker = 0;
float speedYLocker = 0;
 int redofPaddle = 124;
 int greenofPaddle = 255;
 int blueofPaddle = 0;
 int levelKeeper = 0;  //if this equals to 50 then that means, it has to go to a new level
 int scoreKeeper = 0;
 int howHightheBricksWillBe = 30; //max is 300 which will bring all the bricks to the ground

 int score = 0; 
 boolean[][] levelChecker = new boolean[n][m];
 
 int bonuspointer = 0;
 float bonusRectx = random(10, 390);
 float bonusRecty = random(250, 320);
 float bonusRectwh = 20;
 int timer3 = 0;
 int bonuscounter = 0;
 
 
void setup(){
size(400,500);
  background(255, 255, 255);
  
  
}

                  
void mouseClicked(){
  mouseclick = true;
    
}
    
    
    
void draw(){
   bonusRecty = random(250, 320);
    bonusRectx = random(10, 390);
  background(255, 255, 255);
  fill(74, 84, 122);
  rect(0, 400, 400, 100);
  
  for(int i = 0; i < check.length; i++){
      for(int j = 0; j<check[i].length; j++){
        int x = collision(i*w , howHightheBricksWillBe+(j*h), w, h, runBallx, y-7, 7);
           speedXLocker = -speedX;
           speedYLocker = -speedY;
           
            
           if(x == 1 && check[i][j] == false){
           speedY = speedY* -1;
           check[i][j] = true;
           levelChecker[i][j] =true;
           scoreKeeper = 1;
           levelKeeper += 1;
         } 
           else if( x == 2 && check[i][j] == false){
             speedY = speedY * -1;
             check[i][j] = true;
             levelChecker[i][j] =true;
             scoreKeeper = 1;
             levelKeeper += 1;
             
           } else if(x == 3 && check[i][j] == false){
            speedX = speedX * -1;
            check[i][j] = true;
            levelChecker[i][j] =true;
            scoreKeeper = 1;
            levelKeeper += 1;
            
           } 
             else if ( x == 4 && check[i][j] == false){
               speedX = speedX * -1;
               check[i][j] = true;
               levelChecker[i][j] =true;
               scoreKeeper = 1;
               levelKeeper += 1;
               
             } else if( x == 5 && check[i][j] == false){
               cornerDirection = 5;
                if ( i == n && j == m){
                  if (cornerDirection == 5){  //This prevents the ball to go through the bricks when it hits two corners at the same time.
                      speedX = speedX * -1;
                      speedY = speedY * -1;
                       check[i][j] = true;
                       levelChecker[i][j] =true;
                       scoreKeeper = 1;
                       levelKeeper += 1;
                  }
               }
             }
            
                 
                 
               if(j == 0){
             fill(255, 0, 25);
             if(scoreKeeper == 1){
               score += 50;
             }
           } else if(j == 1){
             fill(255, 255, 0);
             if(scoreKeeper == 1){
               score += 40;
           } 
           }  else if (j == 2){
             fill(0, 255, 153);
             if(scoreKeeper == 1){
               score += 30;
           }
           }  else if (j == 3){
             fill(165, 0, 255);
             if(scoreKeeper == 1){
               score += 20;
           }
           }  else if (j == 4){
             fill(97, 8, 214);
             if(scoreKeeper == 1){
               score += 10;
           }
           }
           
            scoreKeeper = 0;
               
           
          if (check[i][j] == true){
             rect(0,0,0,0);
           }
             else if (check[i][j] == false){
               stroke(255);
               rect(i*w, howHightheBricksWillBe+(j*h), w, h);
             }  
        
          println(check[i][j]);
          
          if(levelKeeper > 49){
         
              resetIfLevelChange();
              //check[i][j] = false;
              
              //runBallx = mouseX + rectw/2;;
              level += 1;
              levelKeeper = 0;
             
              
          }
            
         
          
      }
  }
  
   
    
    fill(redofPaddle, greenofPaddle, blueofPaddle);
    float rectx = mouseX;
    noStroke();
    rect(rectx,yOFrect,rectw,recth);
    mouseXchecker=mouseX;
    redofPaddle = 123;
    greenofPaddle = 255;
    
  if (rectx> 340){
    rectx = 340;
  } else {
    rectx = mouseX;
  }
  
  if(mouseclick == true && livesChecker < 3){
    stroke(0, 188, 84);
    fill(0, 247, 111);;
    ellipse(runBallx , y - 7 , 14, 14);
    
    
      int paddleBounce = collision(rectx,yOFrect,rectw,recth,runBallx, y - 7 ,7); //Collision with the paddle
           
           if(paddleBounce == 1){
             speedY = speedY *-1;
             
             redofPaddle = 0;
             greenofPaddle = 0;
           } else if(paddleBounce == 3 || paddleBounce == 4){
             speedX = speedX * -1;
             redofPaddle = 0;
             greenofPaddle = 0;
           } else if(paddleBounce == 5){
             speedX = speedX * -1;
             speedY = speedY * -1;
             greenofPaddle = 0;
             redofPaddle = 0;
           } else if(runBallx >385 || runBallx<15 ){
              speedX = speedX* -1;
              redofPaddle = 0;
              greenofPaddle = 0;
    
            }


         if (y<15){
           speedY = speedY* -1;
          } else if( y > 410){
             livesChecker++;
             mouseclick= false;
             y = 345;
             
            
      }
  
      
      runBallx+=speedX;
      y+=speedY;
  
     
           if(mouseclick==false && livesChecker > 0){
             ellipse(mouseX + rectw/2, yOFrect - 7, 14,14);
             stroke(0, 188, 84);
             fill(0, 247, 111);
                stroke(1);
                runBallx = mouseX + rectw/2;
                speedX =2.0;
                speedY= 5.0;
                
           }
 }
  else if(mouseclick==false){
   stroke(0, 188, 84);
   fill(0, 247, 111);
   ellipse(mouseX + rectw/2, yOFrect - 7, 14,14);
   fill(255);
   stroke(1);
   runBallx = mouseX + rectw/2;
   speedX =-2.0;
   speedY= 5.0;
  }
  fill(255);

//
 //LINE 277 to 334 is a work in progress for a random brick appearing score%500 == 0 


  //bonuspointer = score%500;
  
  //if(bonuspointer == 0){
   // bonuscounter = 0;
  //} else { bonuscounter++;
  //}
  //if(bonuscounter == 0){
   
   // bonusRectwh = 20;
   // timer3++;
   /// fill(random(0,255));
   // rect(bonusRectx,bonusRecty, bonusRectwh, bonusRectwh);
    //if(timer3>600){
    //  bonusRectx = 0;
    //  bonusRecty = 0;
    //  bonusRectwh = 0;
    //}
    //    int bonusCollision = collision(bonusRectx, bonusRecty, bonusRectwh, bonusRectwh, runBallx, y-7, 7);
 //
           
            
      //     if(bonusCollision == 1){
       //    speedY = speedY* -1;
      //     score += 200;
       //    bonusRectx = 0;
       //    bonusRecty = 0;
       //    bonusRectwh = 0;
         
       //  } 
      //    else if( bonusCollision == 2){
       //      speedY = speedY * -1;
       //      score += 200;
       //       bonusRectx = 0;
      //        bonusRecty = 0;
      //        bonusRectwh = 0;
             
      //     } else if(bonusCollision == 3){
       //     speedX = speedX * -1;
       //     score += 200;
        //    bonusRectx = 0;
        //    bonusRecty = 0;
      //      bonusRectwh = 0;
        //   } 
         //    else if ( bonusCollision == 4){
         //      speedX = speedX * -1;
         //      score += 200;
         //      bonusRectx = 0;
         //      bonusRecty = 0;
         //      bonusRectwh = 0;
         //    } else if( bonusCollision == 5){
          //            score += 200;
          //            speedX = speedX * -1;
            //          speedY = speedY * -1;
           //           bonusRectx = 0;
           //           bonusRecty = 0;
          //            bonusRectwh = 0;
          //        }
    //}
  
      
      
//All texts
highscoregetter = score;

 if(highscoregetter > highscore){
   highscore = highscoregetter;
 } 
 
 text("High Score: " + highscore, 250, 460);
    
    
    textSize(15);
        if( livesChecker == 0){
        text("Lives left: 3",10, 430);
          } else if(livesChecker == 1){
             text("Lives left: 2",10, 430);
               } else if(livesChecker == 2){
                  text("Lives left: 1",10, 430);
                    } else if(livesChecker == 3){
                       gameover = 1;
                    }
                        
                       if(gameover == 1){
                        timer1();
                        textSize(15);
                        fill(0,0,0);
                        text("GAME OVER!", 150, 100);
                        text("NO MORE LIVES LEFT!", 130, 130);
                        
                        resetIfGameIsOver();
                        gameover = 0;
                       }
         
         textSize(15);
         text("Level" + level, 300, 430);
         textSize(15);
         text("Score:" + score, 10, 460);
         
         
          println(mouseclick);
          println(runBallx);
          println(livesChecker);
          
          if(level == 20){              //Highest Level
            winner = 1;
          }
          
          if(winner == 1){
            timer2();
            textSize(15);
            fill(0,0,0);
            text("YOU WIN!", 150, 100);
            text("Thanks for playing", 130, 130);
            resetIfGameIsOver();
            winner = 0;
          }
          
          
            
  }
 
 //end of draw
 
int collision(float xr, float yr, float wr, float hr, float xc, float yc, float rc) {
  //corner collision 
  if(dist(xc, yc, xr, yr) < rc){return 5;}
  if(dist(xc, yc, xr+wr, yr) < rc){return 5;}
  if(dist(xc, yc, xr, yr+hr) < rc){return 5;}
  if(dist(xc, yc, xr+wr, yr+hr) < rc){return 5;}
  
  for (float xt = xr; xt < xr + wr; xt++) {
    //top collision
    if (dist(xc, yc, xt, yr) < rc) { 
      return 1;
    }
    //bottom collision
    if (dist(xc, yc, xt, yr+hr) < rc) {
      return 2;
    }
  }

  for (float yt = yr; yt < yr + hr; yt++) {
    //left collision
    if (dist(xc, yc, xr, yt) < rc) {
      return 3;
    }
    //right collision
    if (dist(xc, yc, xr+wr, yt) < rc) {
      return 4;
    }
  }
  
  //no collision
  return -1;
}


void resetIfLevelChange(){
     yOFrect = 360;
     rectw = 50;
     mouseXchecker = 0;
     y = 345;
     recth = 15;
     for(int i = 0; i < check.length; i++){
      for(int j = 0; j<check[i].length; j++){
        check[i][j] = false;
      }
     }
     runBallx = mouseX +rectw/2;
     mouseclick = false;
     speedX *= 1.5;
     speedY *= 1.5;
     cornerDirection = 0;
     speedXLocker = 0;
     speedYLocker = 0;
     redofPaddle = 124;
     greenofPaddle = 255;
     blueofPaddle = 0;
     howHightheBricksWillBe = 30;
     
}


void resetIfGameIsOver(){
     
     yOFrect = 360;
     rectw = 50;
     mouseXchecker = 0;
     y = 345;
     recth = 15;
     for(int i = 0; i < check.length; i++){
      for(int j = 0; j<check[i].length; j++){
        check[i][j] = false;
      }
     }
     runBallx = mouseX +rectw/2;
     mouseclick = false;
     speedX *= 1.3;
     speedY *= 1.3;
     cornerDirection = 0;
     speedXLocker = 0;
     speedYLocker = 0;
     redofPaddle = 124;
     greenofPaddle = 255;
     blueofPaddle = 0;
     howHightheBricksWillBe = 30;
     
     levelKeeper = 0;
}


void timer1(){
      timer1 ++;
      gamerestartingrect = 400;
      rect(0,0,gamerestartingrect,gamerestartingrect);
      fill(0);
      textSize(textsize);
      textsize -=0.5;
      
      if(timer1< 600){
        textSize(15);
        text("SCORE : " + score, 160, 200);
        text("HIGH SCORE: " + highscore, 140, 170);
      }
      if(textsize == 15){
        textsize = 40;
      }
      if(timer1>=60 && timer1 < 120){
        text("5 Seconds", 160, 300);
        
      }
      else if(timer1>=120 && timer1 < 180){
        text("4 Seconds", 160, 300);
        
      }
      else if(timer1>=180 && timer1 < 240){
        text("3 Seconds", 160, 300);
    
      }
      else if(timer1>=240 && timer1 < 300){
        text("2 Seconds", 160, 300);
  
      }
      else if(timer1>=300 && timer1 < 360){
        text("1 Seconds", 160, 300);
     
      }
      else if(timer1>= 420 && timer1 < 600){
        textSize(20);
        text("RESTARTING", 150, 300);
        text("Your high score will be saved", 70, 350);
      } else if(timer1>600){
        gamerestartingrect = 0;
         
        mouseclick = false;
        livesChecker = 0;
        timer1 = 0;
        score = 0;
      }
      
}


void timer2(){
      timer2 ++;
      gamerestartingrect = 400;
      rect(0,0,gamerestartingrect,gamerestartingrect);
      fill(0);
      textSize(textsize);
      textsize -=0.5;
       if(timer2< 600){
        textSize(15);
        text("SCORE : " + score, 160, 200);
        text("HIGH SCORE: " + highscore, 140, 170);
      }
      if(textsize == 15){
        textsize = 40;
      }
      if(timer2>=60 && timer2 < 120){
        text("5 Seconds", 160, 300);
        
      }
      else if(timer2>=120 && timer2< 180){
        text("4 Seconds", 160, 300);
        
      }
      else if(timer2>=180 && timer2 < 240){
        text("3 Seconds", 160, 300);
    
      }
      else if(timer2>=240 && timer2 < 300){
        text("2 Seconds", 160, 300);
  
      }
      else if(timer2>=300 && timer2 < 360){
        text("1 Seconds", 160, 300);
     
      }
      else if(timer2>= 420 && timer2 < 600){
        textSize(25);
        text("RESTARTING", 170, 300);
        text("Your high score will be saved", 70, 350);
      } else if(timer2>600){
        gamerestartingrect = 0;
         
        mouseclick = false;
        level = 0;
        timer1 = 0;
        score = 0;
      }
      
}