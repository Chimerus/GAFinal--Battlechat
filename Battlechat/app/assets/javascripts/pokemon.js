"use strict";

class Pokemon{
  // initializer
	constructor(p1, p2) {
		this.p1 = p1
		console.log(p1)
		this.p2 = p2
		console.log(p2)
    // random pokemon
    let p = [['Voltorb','images/voltorb.png',100,1],['Mew','images/mew.png',100, 1],['Kabutops','images/kabutops.png', 100,1],['Eevee','images/eevee.png',100,1],['Pikachu','images/pikachu.png',100,1]]

    this.player1 = ['Pikachu', 'images/pikachuBack.png',100,1]
    this.player2 = p[Math.floor((Math.random()*p.length))];
    // this.player2 = ['Eevee','images/eevee.png',100,1]
  }

  // TODO later: add different pokemon in!
  // chooseEnemy() {
  // //picks random enemy from pokemon array. populates initial page with their data. 
  // // var chosen = Math.floor((Math.random()*pokemon.length));
  // return ['Kabutops','images/kabutops.png',100,1];
  // }

  game_start(){
  document.getElementById('battleTheme').play();
  $("div#enemy p.name").text("Blue's "+this.player2[0]);
  $("div#enemy span.health").text(this.player2[2]);
  $("#enemy_img").attr("src",this.player2[1]);

  $("div#player p.name").text("Red's "+this.player1[0]);
  $("div#player span.health").text(this.player1[2]);
  $("#player_img").attr("src",this.player1[1]);
  $("#status_text").text("I choose you, "+this.player2[0]+ "!");
  }

  // on game over, stop music, hide elements so can't be clicked on.
  game_over(who){
    let what
    if (who == "Red") {
      what = $("#enemy_img")
    } else {
      what = $("#player_img")
    }
    document.getElementById('battleTheme').pause();
    what.fadeOut(1500);
    window.setTimeout(function(){
      document.getElementById("status_text").innerHTML= who+" is victorious!";
    },805);
    window.setTimeout(function(){
      $('#bg_image').hide();
    }, 4000);
  }

  // change hp by what happened
  updateHp(hp1, hp2){
    $("div#player span.health").text(hp1);
    $("div#enemy span.health").text(hp2);
  }

  //Changing the attack text by damage value for flavor
  pikaPi(who, dmg){
    if (dmg <= 5){
      document.getElementById("status_text").innerHTML= who+"'s Pikachu used Tail Whip for "+dmg+" damage!";
    } else if(dmg<=15){
      document.getElementById("status_text").innerHTML= who+"'s Pikachu used Thunder Shock for "+dmg+" damage!";
    } else {
      document.getElementById("status_text").innerHTML="<h2 style=\"color: yellow;\"><strong>PIKAA-CHUUUU!!!</strong></h2>";
      window.setTimeout(function(){
        document.getElementById("status_text").innerHTML= who+"'s Pikachu unleashes Thunderbolt for "+dmg+" damage!";
      }, 800);
    }
  }

  // attack debuff
  taunt(who) {
    document.getElementById("status_text").innerHTML= who+"'s Pikachu growls menacingly, reducing opponent's attack!"
  }

 //animation functions!
 shake(who){
  let what
  if (who == "Red") {
    what = $("#enemy_img")
  } else {
    what = $("#player_img")
  }

 for(var i=0; i<3; i++){
   if(i%2!=0){
     what.animate({marginLeft: "+=40",},50,function(){
       what.animate({marginLeft: "-=40",},50,function(){
       })
     });}
   else{
     what.animate({marginLeft: "-=40",},50,function(){
       what.animate({marginLeft: "+=40",},50,function(){
       })
   });}  
   }
 }

  heal(who){
  let what
  if (who == "Red") {
    what = $("#player_img")
  } else {
    what = $("#enemy_img")
  }

 for(var i=0; i<3; i++){
   if(i%2!=0){
     what.animate({opacity: 1},100,function(){
       what.animate({opacity: 0.5},100,function(){
       })
     });}
   else{
     what.animate({opacity: 0.5},100,function(){
       what.animate({opacity: 1},100,function(){
       })
   });}  
   }
  document.getElementById("status_text").innerHTML= who+"'s Pikachu heals!"
 }

 charge(who) {
  let what
  if (who == "Red") {
    what = $("#player_img")
  } else {
    what = $("#enemy_img")
  }
  what.animate({opacity: 0.5},1020,function(){
    what.animate({opacity: 1},500,function(){})
    });
  document.getElementById("status_text").innerHTML= who+"'s Pikachu increases its bloodlust!";
  }

  fade(who) {
    let what
    if (who == "Red") {
      what = $("#enemy_img")
    } else {
      what = $("#player_img")
    }
    what.fadeOut(1500);
  }

};

window.Pokemon = Pokemon;
// TODO add additional Pokemon other than Pikachu! Would like them to be able to choose their pokemon.
	// var pokemon = [
	// 	['Voltorb','images/voltorb.png',100,1],
	// 	['Charizard','images/charizard.png',200,1.75],
	// 	['Gyarados','images/gyarados.png',125,1.30],
	// 	['Mew','images/mew.png',75,1.25],
	// 	['Geodude','images/geodude.png',90,1],
	// 	['Snorlax','images/snorlax.png',110,1.10],
	// 	['Kabutops','images/kabutops.png',95,1],
	// 	['Eevee','images/eevee.png',60,0.75],
	// 	['Beedrill','images/beedrill.png',70,0.75],
	// 	['Magikarp','images/magikarp.gif',40,0.5],
	// 	['Gastly','images/gastly.png',50,0.5],
 //    ['Pikachu','images/pikachu.png',100,1]

