return {
	entry = function(_, args)
		local h = ya.sync(function()
			ya.manager_emit("shell", {
				block = true,
				confirm = false,
				args = { "tar", "-xf", args[1], "-C", "." },
			})
			ya.manager_emit("reload", {})
		end)
		h(args)
	end,
}
