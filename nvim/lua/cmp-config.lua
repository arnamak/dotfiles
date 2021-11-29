local luasnip = require("luasnip")
require("cmp-npm").setup({})
local cmp = require("cmp")

cmp.setup(
  {
    completion = { autocomplete = { cmp.TriggerEvent.TextChanged }, completeopt = "menu,menuone,noinsert" },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    documentation = { border = vim.g.floating_window_border_dark },
    experimental = { native_menu = false, ghost_text = true },
    sources = cmp.config.sources(
      {
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer", priority = 110 },
        { name = "nvim_lsp", priority = 120 },
        { name = "npm", keyword_length = 4 },
        { name = "fuzzy_path" },
        { name = "fuzzy_buffer" },
      }
    ),
    mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<A-n>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
          else
            fallback()
          end
        end, { "i", "s", "c" }
      ),
      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }
      ),
    },
    sorting = {
      comparators = {
        require("cmp_fuzzy_buffer.compare"),
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.kind,
        require("cmp-under-comparator").under,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    formatting = {
      format = require("lspkind").cmp_format(
        {
          with_text = true,
          menu = ({
            path = "[P]",
            npm = "[NPM]",
            buffer = "[B]",
            nvim_lsp = "[LSP]",
            fuzzy_path = "[FuzzyP]",
            fuzzy_buffer = "[FuzzyB]",
          }),
        }
      ),
    },
  }
)

cmp.setup.cmdline(
  "/", { sources = cmp.config.sources({ { name = "nvim_lsp_document_symbol" } }, { { name = "buffer" } }) }
)

cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "fuzzy_path" } }, { { name = "cmdline" } }) })

--[[ local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").efm.setup({ capabilities = capabilities }) ]]
