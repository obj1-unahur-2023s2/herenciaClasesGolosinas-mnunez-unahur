/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }

/*
 * Golosinas
 */
 class Golosina {
	var peso
	var sabor
	var precio
	
	method peso() { return peso }
	method sabor() { return sabor }
	method precio() { return precio }
 }
 
 class GolosinaSinGluten inherits Golosina {
	method libreGluten() { return true } 	
 }

 class GolosinaConGluten inherits Golosina {
	method libreGluten() { return false } 	
 }

 
 class Bombon inherits GolosinaSinGluten(peso = 15, sabor=frutilla, precio=5) {
	
	method mordisco() { peso = peso * 0.8 - 1 }
}

class BombonDuro inherits Bombon {
	override method mordisco() {
		peso = 0.max(peso-1)
	}
	
	method gradoDeDureza() = if(peso > 12) 3 else if(peso < 8) 1 else 2
}


class Alfajor inherits GolosinaConGluten(peso = 15, sabor=chocolate, precio=12){	
	method mordisco() { peso = peso * 0.8 }
}

class Caramelo inherits GolosinaSinGluten(peso = 5, precio=12){
	method mordisco() { peso = peso - 1 }
}


class Chupetin inherits GolosinaSinGluten(peso = 7, sabor= naranja, precio=2){
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea inherits GolosinaConGluten(peso = 250, sabor=vainilla, precio=5){
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
}

class Chocolatin inherits GolosinaConGluten(sabor=chocolate){
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var comido = 0
	
	method pesoInicial(unPeso) { peso = unPeso }
	override method peso() { return (peso - comido).max(0) }
	method mordisco() { comido = comido + 2 }

}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti inherits Golosina(peso=5) {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	override method sabor() { return sabores.get(saborActual % 3) }	

	override method precio() { return (if(self.libreGluten()) 7 else 10) }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
