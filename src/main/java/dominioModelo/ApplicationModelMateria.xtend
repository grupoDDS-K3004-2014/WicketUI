package dominioModelo

import java.io.Serializable
import org.uqbar.commons.utils.ApplicationContext
import java.util.List
import java.util.ArrayList

class ApplicationModelMateria implements Serializable {

	@Property Materia materiaSeleccionada
	@Property List<Materia> materias
	@Property List<String> ubicaciones
	@Property Nota notaSeleccionada

	def HomeMaterias getHomeMaterias() {
		ApplicationContext.instance.getSingleton(typeof(Materia))
	}

	def void conseguirMaterias() {
		materias = new ArrayList<Materia>
		materias = this.getHomeMaterias().getMaterias()
	}

	def crearMateria(Materia materia) {
		this.getHomeMaterias.create(materia)
		this.conseguirMaterias
	}

	def List<String> conseguirUbicaciones() {
		this.ubicaciones = new ArrayList
		this.ubicaciones = #["1er cuatrimestre - Nivel 1", "1er cuatrimestre - Nivel 2", "1er cuatrimestre - Nivel 3"]
		return ubicaciones
	}

	def void eliminarNotaSeleccionada() {
		materiaSeleccionada.eliminarNota(notaSeleccionada)
		notaSeleccionada = null
		conseguirMaterias()

	}
}
