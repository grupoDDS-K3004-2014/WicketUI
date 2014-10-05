package dominioModelo

import org.uqbar.commons.model.CollectionBasedHome
import org.apache.commons.collections15.Predicate
import dominioModelo.Materia
import java.util.List

class HomeMaterias extends CollectionBasedHome<Materia> {

	new() {
		this.init
	}

	def void init() {
				var nota1 = new Nota("10/11/2004", "1er Parcial", true)
		var nota2 = new Nota("20/11/2004", "TP", true)
		var nota3 = new Nota("04/07/2011", "2do parcial", true)
		var nota4 = new Nota("17/09/2011", "1er Parcial", false)
		this.create("Algoritmos", "2004", false, "Sarlanga", newArrayList(nota1, nota2), "1er cuatrimestre - Nivel 1")
		this.create("Fisica II", "2011", true, "CosmeFulanito", newArrayList(nota3, nota4), "1er cuatrimestre - Nivel 1")
	}

	def void create(String nombreMateria, String anioCursada, Boolean finalAprobado, String profesor, List<Nota> notas,
		String momentoCursada) {
		var materia = new Materia
		materia.nombre = nombreMateria
		materia.anioCursada = anioCursada
		materia.finalAprobado = finalAprobado
		materia.profesor = profesor
		materia.notas = notas
		materia.momentoCursada = momentoCursada
		this.create(materia)
	}

	override protected Predicate<Materia> getCriterio(Materia example) {
		null
	}

	override createExample() {
		new Materia
	}

	override getEntityType() {
		typeof(Materia)
	}

	def List<Materia> getMaterias() {
		allInstances.toList
	}

}
