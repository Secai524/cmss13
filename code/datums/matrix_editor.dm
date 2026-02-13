
/client
	var/list/stored_matrices
	var/selected_matrix = ""

/client/proc/matrix_editor()
	set name = "Matrix Editor"
	set category = "Debug"

	if(!usr.client || !usr.client.admin_holder || !(usr.client.admin_holder.rights & (R_DEBUG|R_ADMIN)))
		to_chat(usr, SPAN_DANGER("仅限开发人员 >:("))
		return

	var/data = "<h2>Stored matrices</h2>"

	if(LAZYLEN(stored_matrices))
		for(var/name in stored_matrices)
			if(name == selected_matrix)
				data += "-> <b>[name]</b><br>"

				var/matrix/M = stored_matrices[name]
				data += "\[[M.a] [M.d] 0\]<br>"
				data += "\[[M.b] [M.e] 0\]<br>"
				data += "\[[M.c] [M.f] 1\]"
			else
				data += "<a href='byond://?_src_=matrices;select_matrix=[name]'>[name]</a>"
			data += "<br>"
	else
		data += "<p>No matrices have been made!</p>"
	data += "<hr>"

	data += {"
		<h2>Matrix operations</h2>
		<a href='byond://?_src_=matrices;operation=add'>Add</a>
		<a href='byond://?_src_=matrices;operation=subtract'>Subtract</a>
		<a href='byond://?_src_=matrices;operation=multiply'>Multiply</a>
		<a href='byond://?_src_=matrices;operation=inverse'>Invert</a>
		<br><hr>
		<a href='byond://?_src_=matrices;operation=translate'>Translate</a>
		<a href='byond://?_src_=matrices;operation=scale'>Scale</a>
		<a href='byond://?_src_=matrices;operation=rotate'>Rotate</a>
		<br><hr>
		<a href='byond://?_src_=matrices;operation=new'>New matrix</a>
		<a href='byond://?_src_=matrices;operation=copy'>Copy selected matrix</a>
		<a href='byond://?_src_=matrices;operation=chname'>Change matrix name</a>
		<a href='byond://?_src_=matrices;operation=delete'>Delete selected matrix</a>
	"}

	show_browser(usr, data, "Matrix Editor", "matrixeditor\ref[src]", width = 600, height = 450)

/client/proc/matrix_editor_Topic(href, href_list)
	if(!usr.client || !usr.client.admin_holder || !(usr.client.admin_holder.rights & (R_DEBUG|R_ADMIN)))
		to_chat(usr, SPAN_DANGER("仅限开发人员 >:("))
		return

	if(href_list["select_matrix"])
		selected_matrix = href_list["select_matrix"]
		matrix_editor()
		return

	if(!href_list["operation"])
		return

	switch(href_list["operation"])
		if("new")
			var/matrix/M

			if(alert("Identity matrix?", "矩阵创建", "Yes", "No") == "Yes")
				M = matrix()
			else
				var/elements_str = input("Please enter the elements of the matrix as a comma-separated string. Elements should be given by column first, not row!", "Matrix elements") as null|text
				if(!elements_str)
					return
				var/list/elements = splittext(elements_str, ",")
				if(length(elements) != 6)
					to_chat(usr, "创建自定义矩阵时，必须明确提供全部6个元素！只提供了[length(elements)]个。")
					return

				for(var/i = 1 to length(elements))
					var/num_ver = text2num(elements[i])
					if(isnull(num_ver))
						to_chat(usr, "无法将第#[i]个元素（[elements[i]]）转换为数字。")
						return
					elements[i] = num_ver

				// arglist doesn't work
				var/a = elements[1]
				var/b = elements[2]
				var/c = elements[3]
				var/d = elements[4]
				var/e = elements[5]
				var/f = elements[6]

				M = matrix(a,b,c,d,e,f)

			var/matrix_name = input("Name your newborn matrix", "矩阵名称") as null|text
			if(!matrix_name || matrix_name == "Cancel")
				return

			if(LAZYACCESS(stored_matrices, matrix_name))
				to_chat(usr, "已存在同名矩阵！")
				return

			LAZYSET(stored_matrices, matrix_name, M)

		if("copy")
			if(!selected_matrix)
				return

			var/matrix_name = input("Give the copy a name", "矩阵名称") as null|text
			if(!matrix_name || matrix_name == "Cancel")
				return

			if(LAZYACCESS(stored_matrices, matrix_name))
				to_chat(usr, "已存在同名矩阵！")
				return

			LAZYSET(stored_matrices, matrix_name, matrix(LAZYACCESS(stored_matrices, selected_matrix)))

		if("chname")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			var/matrix_name = input("Enter the new matrix name", "矩阵名称") as null|text
			if(!matrix_name || matrix_name == "Cancel")
				return

			if(LAZYACCESS(stored_matrices, matrix_name))
				to_chat(usr, "已存在同名矩阵！")
				return

			LAZYREMOVE(stored_matrices, selected_matrix)
			LAZYSET(stored_matrices, matrix_name, M)
			selected_matrix = matrix_name

		if("delete")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			if(alert("Are you sure you want to delete [selected_matrix]?", "矩阵删除", "Yes", "No") != "Yes")
				return

			qdel(M)
			LAZYREMOVE(stored_matrices, selected_matrix)
			selected_matrix = ""

		if("rotate")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			var/deg = input("Enter how much to rotate the matrix by. The angle is clockwise rotation in degrees.", "矩阵旋转") as null|num
			if(isnull(deg))
				return

			M.Turn(deg)

		if("scale")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			var/sx = input("Enter how much to scale the matrix by in the X direction.", "矩阵缩放") as null|num
			if(isnull(sx))
				return

			var/sy = input("Enter how much to scale the matrix by in the Y direction.", "矩阵缩放") as null|num
			if(isnull(sy))
				return

			M.Scale(sx, sy)

		if("translate")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			var/tx = input("Enter how much to translate the matrix by in the X direction.", "矩阵平移") as null|num
			if(isnull(tx))
				return

			var/ty = input("Enter how much to translate the matrix by in the Y direction.", "矩阵平移") as null|num
			if(isnull(ty))
				return

			M.Translate(tx, ty)

		if("invert")
			if(!selected_matrix)
				return

			var/matrix/M = LAZYACCESS(stored_matrices, selected_matrix)
			if(!M)
				return

			M.Invert()

		if("multiply")
			if(!selected_matrix)
				return

			var/matrix/A = LAZYACCESS(stored_matrices, selected_matrix)
			if(!A)
				return

			var/other_m = tgui_input_list(usr, "选择要与之相乘的另一个矩阵：", "矩阵乘法", (stored_matrices + "Cancel"))
			if(!other_m || other_m == "Cancel")
				return

			var/matrix/B = LAZYACCESS(stored_matrices, other_m)
			if(!B)
				return

			var/left_right = alert("Multiply with [other_m] from the left or the right?", "矩阵乘法", "Left", "Right")
			if(left_right == "Left")
				// Since matrix multiplication directly alters the datum, store the old B so we can set it back later
				var/old_b = matrix(B)
				B.Multiply(A)
				LAZYSET(stored_matrices, selected_matrix, B)
				LAZYSET(stored_matrices, other_m, old_b)
			else if(left_right == "Right")
				A.Multiply(B)

		if("subtract")
			if(!selected_matrix)
				return

			var/matrix/A = LAZYACCESS(stored_matrices, selected_matrix)
			if(!A)
				return

			var/other_m = tgui_input_list(usr, "选择要与之相减的另一个矩阵：", "Matrix subtraction", (stored_matrices + "Cancel"))
			if(!other_m || other_m == "Cancel")
				return

			var/matrix/B = LAZYACCESS(stored_matrices, other_m)
			if(!B)
				return

			A.Subtract(B)

		if("add")
			if(!selected_matrix)
				return

			var/matrix/A = LAZYACCESS(stored_matrices, selected_matrix)
			if(!A)
				return

			var/other_m = tgui_input_list(usr, "选择要与之相加的另一个矩阵：", "Matrix addition", (stored_matrices + "Cancel"))
			if(!other_m || other_m == "Cancel")
				return

			var/matrix/B = LAZYACCESS(stored_matrices, other_m)
			if(!B)
				return

			A.Add(B)

	matrix_editor()
