package dominioModelo

import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException

@Observable
class Nota extends Entity implements Cloneable {
	@Property String fecha
	@Property String descripcion
	@Property Boolean aprobado

	new(String fecha2, String desc, Boolean aprob) {
		fecha = fecha2
		descripcion = desc
		aprobado = aprob
	}

	new() {
	}

	override clone() {
		super.clone()
	}

	def copiarA(Nota destino) {
		destino.fecha = fecha
		destino.descripcion = descripcion
		destino.aprobado = aprobado
	}

	def validate() {
		validateFecha
		validateDescripcion
		validateAprobado
	}

	def validateAprobado() {
		if (aprobado == null) {
			throw new UserException("Seleccione el estado de la nota")
		}
	}

	def validateFecha() {
		validateExistencia
		validateLargo
		validateFormato

	}

	def validateFormato() {
		if ((!fecha.substring(2, 3).equals("/")) || (!fecha.substring(5, 6).equals("/"))) {
			throw new UserException("Formato de fecha invalida, intente con DD/MM/AAAA")
		}
	}

	def validateLargo() {
		if (fecha.length != 10) {
			throw new UserException("Formato de fecha invalida, intente con DD/MM/AAAA")
		}
	}

	def validateDescripcion() {
		if ((descripcion == null) || (descripcion.empty)) {
			throw new UserException("Ingrese una descripción")
		}
	}

	def validateExistencia() {
		if (fecha == null) {
			throw new UserException("Ingrese una fecha")
		}
	}

	def void copiarValoresDe(Nota nota) {
		fecha = nota.fecha
		descripcion = nota.descripcion
		aprobado = nota.aprobado
	}

}
