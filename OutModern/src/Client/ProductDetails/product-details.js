var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
    showSlides((slideIndex += n));
}

function showSlides(n) {
    var i;
    var dots = document.getElementsByClassName("demo");
    var slides = document.getElementsByClassName("slides");
    if (n > slides.length) {
        slideIndex = 1;
    }
    if (n < 1) {
        slideIndex = slides.length;
    }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" opacity-off", "");
        dots[i].style.border = "2px solid rgb(138, 138, 138)";
    }
    alert(modalImg)
    dots[slideIndex - 1].style.border = "2px solid #000";
    dots[slideIndex - 1].className += " opacity-off";
    slides[slideIndex - 1].style.display = "flex";
}

// The three images at bottom
function currentDiv(n) {
    showDivs((slideIndex = n));
}

function showDivs(n) {
    var i;
    var x = document.getElementsByClassName("slides");
    var dots = document.getElementsByClassName("demo");
    if (n > x.length) {
        slideIndex = 1;
    }
    if (n < 1) {
        slideIndex = x.length;
    }
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" opacity-off", "");
        dots[i].style.border = "2px solid rgb(138, 138, 138)";
    }
    x[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " opacity-off";
    dots[slideIndex - 1].style.border = "2px solid #000";
}
