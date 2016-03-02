"use strict";

class Pokemon{
	constructor(p1, p2) {
		this.p1 = p1
		console.log(p1)
		this.p2 = p2
		console.log(p2)
    this.player1 = ['Pikachu', 'images/pikachu.png',100,1]
    this.player2 = ['Kabutops','images/kabutops.png',100,1]
  }

  // chooseEnemy() {
  // //picks random enemy from pokemon array. populates initial page with their data. 
  // // var chosen = Math.floor((Math.random()*pokemon.length));
  // return ['Kabutops','images/kabutops.png',100,1];
  // }

  game_start(){
  let game_start = new Audio('./sounds/battleTheme.mp3');
    game_start.play();
  // var enemy = chooseEnemy();
  // var enemy =['Kabutops','images/kabutops.png',100,1]
  $("div#enemy p.name").text(this.player2[0]);
  $("div#enemy p.health").text("Health: "+ this.player2[2]);
  $("#enemy_img").attr("src",this.player2[1]);
  // $("#status_text").text(" A wild "+this.player2[0]+ " appeared!");

  $("div#player p.name").text(this.player1[0]);
  $("div#player p.health").text("Health: "+ this.player1[2]);
  $("#player_img").attr("src",this.player1[1]);
  $("#status_text").text("I choose you, "+this.player2[0]+ "!");
  }

  attack(player){
    if (player == "Red"){
      // console.log("Red Attacks!");
      this.redAttack();
    } else {
      this.blueAttack();
    }
  }


  redAttack() { 
  //10% chance to miss.
  //90% chance to do between 5-30 damage. 
  //after completed, says 'enemy will attack in 3 seconds' (buttons hidden during this time)
  //check if enemy health is <= 0.
  //If Enemy HP <=0, hide buttons to end game!
  let acc = Math.floor((Math.random()*10)+1);
  // if(acc === 1){
    // $("#status_text").text("You Missed! Enemy will attack in 3 seconds...");
    // $("#heal_btn,#attack_btn").hide();
    // window.setTimeout(enemyAttack, 3000);
  // } else {
    // shake($("#enemy_img"));
    // $("#status_text").text("");
     let dmg = Math.floor((Math.random()*30*this.player1[3])+5);
     this.pikaPi(dmg);
     this.player2[2]-=dmg;
     $("div#enemy p.health").text("Health: "+ this.player2[2]);
     //Player win condition, hide buttons and stop music
     // if(enemy[2] <=0){
     //  document.getElementById("enemy_img").style.transform = "rotate(90deg)";
     //  document.getElementById("status_text").innerHTML=enemy[0]+" has Fainted! <br><strong>You Win!</strong>";
     //  $("#heal_btn,#attack_btn").hide();
     //  game_start.pause();
     // } else {
     //  $("#heal_btn,#attack_btn").hide();
     //  window.setTimeout(enemyAttack, 3000);
     // }
    }
  // }

  blueAttack() {
  // 10% chance to miss.
  // 90% chance to do between 5-30 damage. 
  // after completed, if you aren't dead... buttons reappear.
  // check if your health <= 0.
  // If Player HP <=0, hide buttons to end game!
  let acc = Math.floor((Math.random()*10)+1);
  // if(acc === 1){
  //   $("#status_text").text("Enemy Missed!");
    // $("#heal_btn,#attack_btn").show();
  // } else {
    // shake($("#pikachu_img"));
      // $("#status_text").text("");
// updated to include attack multiplier for each pokemon
      let dmg = Math.floor((Math.random()*30*this.player2[3])+5);
      $("#status_text").text("Enemy did "+dmg+" damage!");
      this.player1[2] -= dmg;
      $("#player .health").text("Health: "+this.player1[2]);
        //Player loss condition, hide buttons and stop music
        // if(pikaHealth<=0){
        //   //chnged to fade out from rotate since the pikachu image doesnt have a lower half!
        //   $("#pikachu_img").fadeOut(1500);
        //   document.getElementById("status_text").innerHTML="Pikachu has Fainted! <br><strong>You Lose!</strong>";
        //   $("#heal_btn, #attack_btn").hide();
        //   game_start.pause();
        // } else {
        //   $("#heal_btn,#attack_btn").show();
        // }
    // }
  }





    //Changing the attack text by damage value for flavor
  pikaPi(dmg){
    if (dmg <11){
      document.getElementById("status_text").innerHTML="Pikachu used Tail Whip for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
    } else if(dmg<21){
      document.getElementById("status_text").innerHTML="Pikachu used Thunder Wave for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
    } else {
      document.getElementById("status_text").innerHTML="<h2 style=\"color: yellow;\"><strong>PIKAA-CHUUUU!!!</strong></h2>";
      window.setTimeout(function(){
        document.getElementById("status_text").innerHTML="Pikachu unleashes Thunderbolt for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
      }, 1500);
    }
  }


};

window.Pokemon = Pokemon;
  

// (function(){
// var pokemon = function(){
// 	var game_start = new Audio('./sounds/battleTheme.mp3');
//   	game_start.play();

// 	var pokemon = [
// 		['Voltorb','images/voltorb.png',100,1],
// 		['Charizard','images/charizard.png',200,1.75],
// 		['Gyarados','images/gyarados.png',125,1.30],
// 		['Mew','images/mew.png',75,1.25],
// 		['Geodude','images/geodude.png',90,1],
// 		['Snorlax','images/snorlax.png',110,1.10],
// 		['Kabutops','images/kabutops.png',95,1],
// 		['Eevee','images/eevee.png',60,0.75],
// 		['Beedrill','images/beedrill.png',70,0.75],
// 		['Magikarp','images/magikarp.gif',40,0.5],
// 		['Gastly','images/gastly.png',50,0.5]
// 	];
// 	//animation function!
// 	function shake(what){
// 	for(var i=0; i<3; i++){
// 		if(i%2!=0){
// 			what.animate({marginLeft: "+=40",},50,function(){
// 				what.animate({marginLeft: "-=40",},50,function(){
// 				})
// 			});}
// 		else{
// 			what.animate({marginLeft: "-=40",},50,function(){
// 				what.animate({marginLeft: "+=40",},50,function(){
// 				})
// 		});}	
// 		}
// 	}
// 	//changing Pikachu's health to a value for adjusting purposes
// 	var pikaHealth = 100;
// 	$("#pikachu .health").text("Health: "+pikaHealth);

	// //Changing the attack text by damage value for flavor
	// function pikaPi(dmg){
	// 	if (dmg <11){
	// 		document.getElementById("status_text").innerHTML="Pikachu used Tail Whip for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
	// 	} else if(dmg<21){
	// 		document.getElementById("status_text").innerHTML="Pikachu used Thunder Wave for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
	// 	} else {
	// 		document.getElementById("status_text").innerHTML="<h2 style=\"color: yellow;\"><strong>PIKAA-CHUUUU!!!</strong></h2>";
	// 		window.setTimeout(function(){
	// 			document.getElementById("status_text").innerHTML="Pikachu unleashes Thunderbolt for "+dmg+" damage! <br>Enemy will attack in 3 seconds...";
	// 		}, 1500);
	// 	}
	// }

	// var chooseEnemy = function(){
	// //picks random enemy from pokemon array. populates initial page with their data. 
	// var chosen = Math.floor((Math.random()*pokemon.length));
	// return pokemon[chosen];
	// }
	// var enemy = chooseEnemy();
	// $("div#enemy p.name").text(enemy[0]);
	// $("div#enemy p.health").text("Health: "+ enemy[2]);
	// $("#enemy_img").attr("src",enemy[1]);
	// $("#status_text").text(" A wild "+enemy[0]+ " appeared!");

// 	var doHeal = function(){
// 	//heals your character with a random amount from 25-50
// 	$("#heal_btn, #attack_btn").hide();
// 	var healed = Math.floor((Math.random()*25)+25);
// 	pikaHealth+=healed;
// 	$("#pikachu .health").text("Health: "+pikaHealth);
// 	//use document.getElement so I can use breakline!
// 	document.getElementById("status_text").innerHTML="Pikachu healed "+healed+ " damage! <br> Enemy will attack in 3 seconds!";
// 	window.setTimeout(enemyAttack, 3000);
// 	}

// 	var enemyAttack = function(){
// 	10% chance to miss.
// 	90% chance to do between 5-30 damage. 
// 	after completed, if you aren't dead... buttons reappear.
// 	check if your health <= 0.
// 	If Player HP <=0, hide buttons to end game!
// 	var acc = Math.floor((Math.random()*10)+1);
// 	if(acc === 1){
// 		$("#status_text").text("Enemy Missed!");
// 		$("#heal_btn,#attack_btn").show();
// 	} else {
// 		shake($("#pikachu_img"));
// 			$("#status_text").text("");
// updated to include attack multiplier for each pokemon
// 		  var dmg = Math.floor((Math.random()*30*enemy[3])+5);
// 		  $("#status_text").text("Enemy did "+dmg+" damage!");
// 		  pikaHealth -= dmg;
// 		 	$("#pikachu .health").text("Health: "+pikaHealth);
// 		 		//Player loss condition, hide buttons and stop music
// 		 		if(pikaHealth<=0){
// 		 			//chnged to fade out from rotate since the pikachu image doesnt have a lower half!
// 		 			$("#pikachu_img").fadeOut(1500);
// 				 	document.getElementById("status_text").innerHTML="Pikachu has Fainted! <br><strong>You Lose!</strong>";
// 				 	$("#heal_btn, #attack_btn").hide();
// 				 	game_start.pause();
// 			 	} else {
// 			 		$("#heal_btn,#attack_btn").show();
// 			 	}
// 		}
// 	}

	// var youAttack = function(){ 
	// //10% chance to miss.
	// //90% chance to do between 5-30 damage. 
	// //after completed, says 'enemy will attack in 3 seconds' (buttons hidden during this time)
	// //check if enemy health is <= 0.
	// //If Enemy HP <=0, hide buttons to end game!
	// var acc = Math.floor((Math.random()*10)+1);
 //  if(acc === 1){
	// 	$("#status_text").text("You Missed! Enemy will attack in 3 seconds...");
	// 	$("#heal_btn,#attack_btn").hide();
	// 	window.setTimeout(enemyAttack, 3000);
	// } else {
	// 	shake($("#enemy_img"));
	// 	$("#status_text").text("");
	// 	 var dmg = Math.floor((Math.random()*30)+5);
	// 	 pikaPi(dmg);
	// 	 enemy[2]-=dmg;
	// 	 $("div#enemy p.health").text("Health: "+ enemy[2]);
	// 	 //Player win condition, hide buttons and stop music
	// 	 if(enemy[2] <=0){
	// 	 	document.getElementById("enemy_img").style.transform = "rotate(90deg)";
	// 	 	document.getElementById("status_text").innerHTML=enemy[0]+" has Fainted! <br><strong>You Win!</strong>";
	// 	 	$("#heal_btn,#attack_btn").hide();
	// 	 	game_start.pause();
	// 	 } else {
	// 	 	$("#heal_btn,#attack_btn").hide();
	// 	 	window.setTimeout(enemyAttack, 3000);
	// 	 }
	// 	}
	// }
	
// 	var addEventListeners = function(){
// 	//add the click events on the attack and heal buttons. 
// 	$("#heal_btn").click(doHeal);
// 	$("#attack_btn").click(youAttack);
// 	}

// 	$(document).ready(function(){
// 		addEventListeners();
// 	})

// })();
// }
