function pullDown() {

  const pullDownButton = document.getElementById("category-lists")
  const pullDownParents = document.getElementById("pull-down")
  // const pullDownChild = document.querySelectorAll(".pull-down-list")

  pullDownButton.addEventListener('mouseover', function(){
    this.setAttribute("style", "background-color:#FFBEDA;")
  })

  pullDownButton.addEventListener('mouseout', function(){
    this.removeAttribute("style", "background-color:#FFBEDA;")
  })

  pullDownButton.addEventListener('click', function() {
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    } else {
      pullDownParents.setAttribute("style", "display:block;")
    }
  })

//   pullDownChild.forEach(function(list) {
//     list.addEventListener('click', function(e) {
      
//     })
//   })
}

window.addEventListener('load', pullDown)