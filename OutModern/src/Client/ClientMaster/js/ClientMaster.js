
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