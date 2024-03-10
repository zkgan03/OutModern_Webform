
// close ads
(() => {
    let adsClsoeBtn = document.querySelector(".nav-ads .fa-solid.fa-xmark");
    adsClsoeBtn.addEventListener("click", () => {
        adsClsoeBtn.parentElement.remove();
    })
})();

// rotate the arrow in nav bar
(() => {
    let navDropDown = document.querySelectorAll(".nav-dropdown");

    navDropDown.forEach(item => {
        item.addEventListener("mouseenter", function () {
            icon = this.querySelector(".fa-angle-down");
            icon.classList.add("fa-rotate-180");
        })
        item.addEventListener("mouseleave", function () {
            icon = this.querySelector(".fa-angle-down");
            icon.classList.remove("fa-rotate-180");
        })
    })
})();

//nav bar scroll
(() => {
    let header = document.getElementById("header");

    window.addEventListener("scroll", () => {
        if (document.documentElement.scrollTop <= 40) {

            if (!header.classList.contains("header-scroll")) return;
            header.classList.remove("header-scroll");

            // Logo transition                     
            header.querySelector("#nav-logo a img").style.width = "100px"
            header.querySelector("#nav-logo").style.marginLeft = "5rem";

            // Company name
            header.querySelector("#outmodern-header").style.fontSize = "0"

            // navigation bar transition
            header.querySelector("#top-nav").style.marginRight = "5rem";
        }
        else if (document.documentElement.scrollTop > 40) {

            header.classList.add("header-scroll")

            // Logo transition 
            header.querySelector("#nav-logo a img").style.width = "0px"
            header.querySelector("#nav-logo").style.marginLeft = "2rem";

            // Company name
            header.querySelector("#outmodern-header").style.fontSize = "1.875rem"

            // navigation bar transition
            header.querySelector("#top-nav").style.marginRight = "1rem";

        }
    })
})();

// drop down
(() => {
    dropDownAll = document.querySelectorAll(".nav-dropdown");

    dropDownAll.forEach(dropDown => {
        const dropDownList = dropDown.querySelector(".drop-down");

        dropDown.addEventListener("mouseenter", () => {
            dropDownList.style.height = "auto";
            const { height } = dropDownList.getBoundingClientRect();
            dropDownList.style.height = "0";
            dropDownList.style.padding = "10px"

            dropDownList.offsetHeight; // force render

            dropDownList.style.height = `${height}px`;
        })

        dropDown.addEventListener("mouseleave", (e) => {
            console.log(e.target)
            dropDownList.style.height = "0px";
            dropDownList.style.padding = "0px"
        })
    });

})();