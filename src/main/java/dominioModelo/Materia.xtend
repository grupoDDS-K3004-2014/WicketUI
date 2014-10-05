package dominioModelo

import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException
import java.util.ArrayList
import java.util.List

class Materia extends Entity {

	@Property String nombre
	@Property String anioCursada
	@Property Boolean finalAprobado
	@Property String profesor
	@Property String momentoCursada
	@Property List<Nota> notas = new ArrayList

	def validar() {
		if (nombre == null) {
			throw new UserException("Ingrese el nombre de la materia")
		}
	}

	def eliminarNota(Nota nota) {
		val notasAux = new ArrayList()
		notasAux.addAll(notas)
		notasAux.remove(nota)
		notas = notasAux
	}

	def agregarNota(Nota nota) {
		notas.add(nota)
	}

}
