local bazel = require("bazel")

vim.api.nvim_create_user_command("Bazel", function(opts)
	if opts.fargs == nil or #opts.fargs == 0 then
		print("No arguments provided")
		return
	end
	if #opts.fargs < 2 then
		-- Run by checking the current file.
		return bazel.run_here(opts.fargs[1], "", {})
	end
	local command = opts.fargs[1]
	local args = table.concat(opts.fargs, " ", 2)
	bazel.execute(command, args, {})
end, {
	nargs = "*",
	complete = function(arg_lead)
		if arg_lead == "" then
			return {
				"build",
				"test",
				"query",
				"cquery",
				"run",
				"clean",
				"coverage",
				"mod",
				"shutdown",
				"sync",
				"version",
			}
		end
		return {}
	end,
})
