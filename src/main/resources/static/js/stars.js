const stars = document.getElementsByClassName("stars");
const full = `<i class="fas fa-star"></i>`;
const half = `<i class="fas fa-star-half"></i>`;
const empty = `<i class="far fa-star"></i>`;

for(let star of stars){
	console.log(star);
	let s = parseFloat(star.innerHTML);
	let t = "";
	for(var i=1; i<=s; i++){
		t += full;
	}
	if(s%1 >= 0.5){
		t += half;
	}
	star.innerHTML = t;
	console.log(t);
}