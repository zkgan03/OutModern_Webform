// Collapse or expand Side Menu
(() => {
    const sideMenu = document.querySelector("#side-menu");
    const logo = document.querySelector("#companyLogo");
    const menuTitle = document.querySelectorAll(".menu-title"); //all the text in menu category
    const menuItemText = document.querySelectorAll(".menu-item-text"); //all the text in menu item

    const logoTextWidth = logo.children[1].getBoundingClientRect().width;
    logo.children[1].style.width = `${logoTextWidth}px` // assign value so have transition (from auto -> given value)

    document.querySelector("#menu-toggler").addEventListener("click", function () {

        if (this.classList.contains("collapsed")) {
            this.classList.remove("collapsed");

            sideMenu.style.paddingLeft = "1.25rem";
            sideMenu.style.paddingRight = "1.25rem";


            logo.children[0].style.width = "0"; // img logo
            logo.children[1].style.width = `${logoTextWidth}px`

            // title for each category
            menuTitle.forEach(text => {
                text.style.display = "block";

            })

            // icon description for each item
            menuItemText.forEach(text => {
                text.style.display = "inline";

            })

        } else {
            this.classList.add("collapsed");

            sideMenu.style.paddingLeft = "0.75rem";
            sideMenu.style.paddingRight = "0.75rem";

            logo.children[0].style.width = "45px"; // img logo
            logo.children[1].style.width = "0";

            // title for each category
            menuTitle.forEach(text => {
                text.style.display = "none";
            })

            // icon description for each item
            menuItemText.forEach(text => {
                text.style.display = "none";

            })
        }

    });
})();