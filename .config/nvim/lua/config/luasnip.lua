local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.config.setup({
	history = true,
	updateevents = "TextChanged,TextChangedI",
})

-- [[ PYTHON ]]

ls.add_snippets("python", {
	s("main", {
		t("def main():"),
		t({ "", "    " }),
		i(1, "pass"), -- Function body placeholder
		t({ "", "", "if __name__ == '__main__':", "    main()" }),
	}),
})

return ls
