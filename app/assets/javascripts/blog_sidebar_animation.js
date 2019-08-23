//function random_no(){
//     var ran=Math.random();
//     jQuery('.blog-sidebar').html(ran);
//}

function ranimation_directions(){
  var animations = ["blind", "drop", "fade"];
  animation = animations[Math.floor(Math.random() * (animations.length))];
  var directions = ["left", "right", "up", "down"];
  var ran = Math.random();
  if (animation == "blind"){
    direction = directions[Math.floor(ran * directions.length)];
    return [animation, direction, direction];
  }
  else if (animation == "drop") {
    if (ran < 0.5){
      directions_new = [directions[0], directions[1]];
      return [animation, directions_new[Math.floor(ran * directions_new.length)], directions_new[Math.floor((1-ran) * directions_new.length)]];
    }
    else {
      directions = [directions[2], directions[3]];
      return [animation, directions[Math.floor(ran * directions.length)], directions[Math.floor((1-ran) * directions.length)]];
    }
  }
  else {
    return [animation, "none", "none"];
  }
}

function change_text(fade_time){
    var displayed = $( ".visible" )[0];
    var animation_dir = ranimation_directions();
    if (displayed == null) {
      displayed = $(".first-msg")[0];
    }
    if ($(displayed).hasClass("last-msg")) {
      var next_displayed = $(".first-msg")[0];
    }
    else {
      var next_displayed = $(displayed).next();
    }
    $(displayed).hide(animation_dir[0], { direction: animation_dir[1] }, fade_time);
    $(displayed).removeClass("visible");
    setTimeout(function(){
      $(next_displayed).show(animation_dir[0], { direction: animation_dir[2] }, fade_time);
      $(next_displayed).removeClass("hidden").addClass("visible");
    }, fade_time+100);
}

//timerRef = window.setInterval(function(){
       /// call your function here
//      random_no();
//}, 3000);
$(document).ready(function(){
    $(".hidden").hide();
    var timerRef;
    clearInterval(timerRef);
    timerRef = window.setInterval(function(){
        change_text(800);
    },5000)
})
