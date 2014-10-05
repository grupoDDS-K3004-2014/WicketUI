package uiWicket

import dominioModelo.ApplicationModelMateria
import dominioModelo.Materia
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.form.CheckBox
import org.apache.wicket.markup.html.form.DropDownChoice
import dominioModelo.Nota

class MateriasPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	@Property var ApplicationModelMateria materiaAppModel

	new() {
		this.materiaAppModel = new ApplicationModelMateria
		val Form<ApplicationModelMateria> materiasForm = new Form<ApplicationModelMateria>("materiasForm",
			new CompoundPropertyModel<ApplicationModelMateria>(this.materiaAppModel))
		this.agregarGrillaResultados(materiasForm)
		this.agregarAcciones(materiasForm)
		this.agregarDetallesMateria(materiasForm)
		this.addChild(materiasForm)
		obtenerMaterias()
	}

	def agregarGrillaResultados(Form<ApplicationModelMateria> parent) {
		val listView = new XListView("materias")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			item.addChild(new XButton("editar").onClick = [|editar(item.modelObject)])
		]
		parent.addChild(listView)
	}

	def agregarAcciones(Form<ApplicationModelMateria> parent) {
		parent.addChild(new XButton("nueva").onClick = [|crear(new Materia)])
	}

	def agregarDetallesMateria(Form<ApplicationModelMateria> parent) {

		parent.addChild(new Label("materiaSeleccionada.nombre"))
		parent.addChild(new TextField<String>("materiaSeleccionada.anioCursada"))
		parent.addChild(new CheckBox("materiaSeleccionada.finalAprobado"))
		parent.addChild(new TextField<String>("materiaSeleccionada.profesor"))
		parent.addChild(
			new DropDownChoice<String>("materiaSeleccionada.momentoCursada") => [
				choices = loadableModel([|materiaAppModel.conseguirUbicaciones()])]
		)
		val listaNotas = new XListView("materiaSeleccionada.notas")
		listaNotas.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("fecha"))
			item.addChild(new Label("descripcion"))
			val checkaprobado = new CheckBox("aprobado")
			checkaprobado.setEnabled = false
			item.addChild(checkaprobado)
			item.addChild(
				new XButton("editarNota").onClick = [ |
					materiaAppModel.notaSeleccionada = item.modelObject
					editarNotaSeleccionada
				])
			item.addChild(
				new XButton("eliminarNota").onClick = [|materiaAppModel.notaSeleccionada = item.modelObject
					materiaAppModel.eliminarNotaSeleccionada])
		]
		parent.addChild(listaNotas)
		parent.addChild(new XButton("nuevaNota").onClick = [|nuevaNota()])
		obtenerMaterias()
	}

	def crear(Materia materia) {
		responsePage = new AgregarMateriaPage(materia, this)
	}

	def editar(Materia materia) {
		materiaAppModel.materiaSeleccionada = materia
		obtenerMaterias()
	}

	def obtenerMaterias() {
		materiaAppModel.conseguirMaterias()
	}

	def editarNotaSeleccionada() {
		responsePage = new EditarNotaPage(materiaAppModel.materiaSeleccionada, materiaAppModel.notaSeleccionada, this, false)
	}

	def nuevaNota() {
		responsePage = new EditarNotaPage(materiaAppModel.materiaSeleccionada, new Nota(), this, true)
	}

}
