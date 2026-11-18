--[[
    Milenium Library example (covers every component)

    Components used here:
      library:window        floating main window (drag, resize grip, auto resize, Insert toggle)
      window:seperator      sidebar section label
      library:tab           sidebar tab, with one or many sub tabs
      page:column           vertical column inside a tab/page
      library:section       group box (optionally fading/collapsible)
      library:toggle        switch (type = "toggle") or box (type = "checkbox"),
                            plus folding toggles that collapse later widgets
      library:slider        min/max/interval slider with suffix + info
      library:dropdown      single, multi and scrolling dropdowns
      library:label         text label
      library:colorpicker   color + alpha picker
      library:textbox       text entry (textbox:set)
      library:keybind       Hold / Toggle / Always keybind (keybind:set / set_mode)
      library:button        action button
      library:list          option list (list:refresh_options)
      library:tabbox        tab strip inside a page (left / middle / right)
      library:sub_window    standalone draggable window with tabs
      library:mini_window   compact sub window that can collapse
      library:notifications notifications:create_notification
      library:init_config   built-in Settings tab (Configs / Interface / Theme)

    Icons are picked FROM THE COMPONENT NAME. Every tab, sub tab, group box and
    sub window page calls resolve_icon(kind, name), which looks the name up in
    ICONS below and returns the icon name for the active provider. Rename a tab
    or section and add its entry to ICONS to give it a different provider icon.
    Switching provider re-applies every tracked icon by name (refresh_icons).

    Provider notice: the names in ICONS cover heroicons, lucide and tabler.
    The library also supports solar, material, fluent and phosphor; add their
    icon names to the same entries if you want to switch to those.
]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/sickletone/sillylua/refs/heads/main/Library.lua"))()

-- Load the molto icon provider up front so every icon below is a provider name.
library:set_icon_provider("heroicons")

-- Providers this example ships icons for, and exposes in the demo dropdown.
local PROVIDERS = {"heroicons", "lucide", "tabler"}

-- Icon names keyed by the component's name. Each entry lists the name for each
-- supported provider, so the same tab/section keeps a matching picture when the
-- provider changes.
local ICONS = {
    tab = {
        Widgets = {heroicons = "cog-6-tooth", lucide = "settings-2", tabler = "settings"},
        Inputs = {heroicons = "pencil-square", lucide = "square-pen", tabler = "edit"},
        Layout = {heroicons = "squares-2x2", lucide = "layout-grid", tabler = "layout-grid"},
        Windows = {heroicons = "window", lucide = "app-window", tabler = "app-window"},
        Icons = {heroicons = "sparkles", lucide = "sparkles", tabler = "sparkles"},
    },
    subtab = {
        Main = {heroicons = "home", lucide = "house", tabler = "home"},
        Columns = {heroicons = "view-columns", lucide = "columns-3", tabler = "columns-3"},
        ["Tab Box"] = {heroicons = "table-cells", lucide = "table", tabler = "table"},
        Fading = {heroicons = "eye", lucide = "eye", tabler = "eye"},
    },
    page = {
        Notes = {heroicons = "document-text", lucide = "file-text", tabler = "file-text"},
        More = {heroicons = "ellipsis-horizontal", lucide = "ellipsis", tabler = "dots"},
        Quick = {heroicons = "bolt", lucide = "zap", tabler = "bolt"},
        ["Left Box"] = {heroicons = "arrow-left", lucide = "arrow-left", tabler = "arrow-left"},
        ["Middle Box"] = {heroicons = "arrows-right-left", lucide = "arrow-left-right", tabler = "arrows-exchange"},
        ["Right Box"] = {heroicons = "arrow-right", lucide = "arrow-right", tabler = "arrow-right"},
    },
    section = {
        Toggles = {heroicons = "adjustments-horizontal", lucide = "toggle-left", tabler = "toggle-left"},
        Values = {heroicons = "chart-bar", lucide = "sliders-horizontal", tabler = "adjustments"},
        Colors = {heroicons = "swatch", lucide = "palette", tabler = "palette"},
        ["Text Entry"] = {heroicons = "pencil", lucide = "type", tabler = "typography"},
        Lists = {heroicons = "list-bullet", lucide = "list", tabler = "list"},
        Dropdowns = {heroicons = "chevron-up-down", lucide = "list-filter", tabler = "selector"},
        Keybinds = {heroicons = "command-line", lucide = "keyboard", tabler = "keyboard"},
        ["Column One"] = {heroicons = "view-columns", lucide = "columns-2", tabler = "columns-2"},
        ["Column Two"] = {heroicons = "view-columns", lucide = "columns-2", tabler = "columns-2"},
        ["Column Three"] = {heroicons = "view-columns", lucide = "columns-2", tabler = "columns-2"},
        ["Left Box"] = {heroicons = "arrow-left", lucide = "arrow-left", tabler = "arrow-left"},
        ["Middle Box"] = {heroicons = "arrows-right-left", lucide = "arrow-left-right", tabler = "arrows-exchange"},
        ["Right Box"] = {heroicons = "arrow-right", lucide = "arrow-right", tabler = "arrow-right"},
        Collapsible = {heroicons = "eye", lucide = "eye", tabler = "eye"},
        Stable = {heroicons = "lock-closed", lucide = "lock", tabler = "lock"},
        Collapsed = {heroicons = "eye-slash", lucide = "eye-off", tabler = "eye-off"},
        ["Main Window"] = {heroicons = "window", lucide = "app-window", tabler = "app-window"},
        ["Sub Window"] = {heroicons = "rectangle-group", lucide = "panel-top", tabler = "layout-bottombar"},
        ["Mini Window"] = {heroicons = "rectangle-stack", lucide = "panel-bottom", tabler = "layout-topbar"},
        Provider = {heroicons = "sparkles", lucide = "sparkles", tabler = "sparkles"},
        Theme = {heroicons = "paint-brush", lucide = "paintbrush", tabler = "brush"},
        ["Icon Size"] = {heroicons = "arrows-pointing-out", lucide = "maximize-2", tabler = "maximize"},
        Extras = {heroicons = "puzzle-piece", lucide = "puzzle", tabler = "puzzle"},
        Notes = {heroicons = "document-text", lucide = "file-text", tabler = "file-text"},
        More = {heroicons = "ellipsis-horizontal", lucide = "ellipsis", tabler = "dots"},
        Quick = {heroicons = "bolt", lucide = "zap", tabler = "bolt"},
    },
}

local FALLBACKS = {
    tab = {heroicons = "squares-2x2", lucide = "layout-grid", tabler = "layout-grid"},
    subtab = {heroicons = "chevron-right", lucide = "chevron-right", tabler = "chevron-right"},
    page = {heroicons = "document-text", lucide = "file-text", tabler = "file-text"},
    section = {heroicons = "cube", lucide = "box", tabler = "box"},
}

-- Resolve a component name to the icon name for the active provider.
local function resolve_icon(kind, name)
    local entry = ICONS[kind] and ICONS[kind][name]
    if entry then
        return entry[library.icon_provider] or entry.heroicons
    end
    local fallback = FALLBACKS[kind]
    return fallback[library.icon_provider] or fallback.heroicons
end

-- Every icon created below is tracked so a provider switch can re-resolve it
-- from its name instead of leaving a stale provider icon behind.
local named_icons = {}
local function track_icon(kind, name, apply)
    named_icons[#named_icons + 1] = {kind = kind, name = name, apply = apply}
end

local function refresh_icons()
    for _, entry in ipairs(named_icons) do
        entry.apply(resolve_icon(entry.kind, entry.name))
    end
end

local function notify(title, info)
    library.notifications:create_notification({name = title, info = info, lifetime = 3})
end

local DEFAULT_ACCENT = library.themes.preset.accent

-- Declared before the helpers so make_tab closes over this local, not a global.
local window

-- Build a sub-tab list whose icons come from the sub-tab names.
local function subtabs(names)
    local list = {}
    for _, name in ipairs(names) do
        list[#list + 1] = {name = name, icon = resolve_icon("subtab", name)}
    end
    return list
end

-- Create a sidebar tab, track its icon + its sub-tab icons, and return its pages.
local function make_tab(options)
    options.icon = resolve_icon("tab", options.name)
    local pages = table.pack(window:tab(options))

    track_icon("tab", options.name, function(icon)
        window:set_tab_icon(options.name, icon)
    end)

    for _, sub in ipairs(options.tabs or {}) do
        local sub_name = type(sub) == "table" and sub.name or sub
        track_icon("subtab", sub_name, function(icon)
            window:set_subtab_icon(options.name, sub_name, icon)
        end)
    end

    return table.unpack(pages, 1, pages.n)
end

-- Create a group box whose icon comes from its name.
local function section(parent, name, size, options)
    options = options or {}
    local group = parent:section({
        name = name,
        size = size,
        default = options.default ~= false,
        fading = options.fading,
        icon = resolve_icon("section", name),
    })
    track_icon("section", name, function(icon)
        group:set_icon(icon)
    end)
    return group
end

-- Page tabs on sub windows / mini windows / tab boxes; icon comes from the name.
local function page_tab(container, name)
    local page = container:tab({name = name, icon = resolve_icon("page", name)})
    track_icon("page", name, function(icon)
        page:set_icon(icon)
    end)
    return page
end

local function box_tab(box, name)
    local page = box:tab({name = name, icon = resolve_icon("page", name)})
    track_icon("page", name, function(icon)
        box:set_tab_icon(name, icon)
    end)
    return page
end

window = library:window({
    name = "silly",
    suffix = ".lua",
    gameInfo = "Milenium Library demo",
    autoResize = true,
})

local initial_auto_resize = window.auto_resize

-- Declared before the tabs so window-tab buttons can control them later.
local notes, mini

--------------------------------------------------------------------------------
-- Widgets
--------------------------------------------------------------------------------
window:seperator({name = "General"})

local widgets_page = make_tab({name = "Widgets", tabs = subtabs({"Main"})})

do
    local toggles = section(widgets_page:column({}), "Toggles", 1)

    toggles:toggle({
        name = "Enable visuals",
        type = "toggle",
        default = true,
        info = "Switch style toggle (the default when type is not set).",
        seperator = true,
        callback = function(on)
            print("[demo] visuals =", on)
        end,
    })

    toggles:toggle({
        name = "Stream proof",
        type = "checkbox",
        default = true,
        info = "Box style checkbox: type = \"checkbox\".",
        seperator = true,
        callback = function(on)
            print("[demo] stream proof =", on)
        end,
    })

    toggles:toggle({
        name = "Advanced options",
        type = "toggle",
        folding = true,
        default = false,
        info = "Folding toggle: every widget created after it collapses.",
        callback = function(on)
            print("[demo] advanced =", on)
        end,
    })

    toggles:slider({
        name = "Nested strength",
        min = 0,
        max = 100,
        default = 50,
        interval = 1,
        suffix = "%",
        seperator = true,
        callback = function(value)
            print("[demo] nested strength =", value)
        end,
    })

    toggles:toggle({
        name = "Nested checkbox",
        type = "checkbox",
        seperator = true,
        callback = function(on)
            print("[demo] nested checkbox =", on)
        end,
    })
end

do
    local widgets_right = widgets_page:column({})

    local values = section(widgets_right, "Values", 0.55)
    values:slider({
        name = "Walk speed",
        min = 16,
        max = 200,
        default = 32,
        interval = 1,
        suffix = " studs",
        info = "Slider with a suffix and an info line.",
        seperator = true,
        callback = function(value)
            print("[demo] walk speed =", value)
        end,
    })
    values:label({
        name = "Label widget",
        info = "Labels are plain readouts. They also accept an info block like this one.",
        seperator = true,
    })

    local colors = section(widgets_right, "Colors", 0.45)
    colors:colorpicker({
        name = "Accent color",
        color = library.themes.preset.accent,
        seperator = true,
        callback = function(color)
            library:update_theme("accent", color)
        end,
    })
    colors:label({
        name = "Live theme",
        info = "This picker calls library:update_theme(\"accent\", color), so the whole window recolors as you drag.",
    })
end

--------------------------------------------------------------------------------
-- Inputs
--------------------------------------------------------------------------------
local inputs_page = make_tab({name = "Inputs", tabs = subtabs({"Main"})})

do
    local inputs_left = inputs_page:column({})

    local text_entry = section(inputs_left, "Text Entry", 0.5)
    local name_box = text_entry:textbox({
        name = "Display name",
        placeholder = "type a name...",
        default = "silly",
        callback = function(text)
            print("[demo] textbox =", text)
        end,
    })
    text_entry:button({
        name = "Set name from source",
        callback = function()
            name_box:set("set by source")
            notify("Textbox", "name_box:set(\"set by source\")")
        end,
    })

    local lists = section(inputs_left, "Lists", 0.5)
    lists:label({name = "List widget", seperator = true})
    local demo_list = lists:list({
        options = {"Option One", "Option Two", "Option Three"},
        callback = function(option)
            print("[demo] list =", option)
        end,
    })
    lists:button({
        name = "Refresh list options",
        callback = function()
            demo_list:refresh_options({"Refreshed A", "Refreshed B", "Refreshed C"})
            notify("List", "list:refresh_options({...}) replaced every row.")
        end,
    })
end

do
    local inputs_right = inputs_page:column({})

    local dropdowns = section(inputs_right, "Dropdowns", 0.6)
    dropdowns:dropdown({
        name = "Single select",
        items = {"Alpha", "Bravo", "Charlie"},
        default = "Alpha",
        seperator = true,
        callback = function(value)
            print("[demo] single select =", value)
        end,
    })
    dropdowns:dropdown({
        name = "Multi select",
        items = {"Red", "Green", "Blue"},
        default = {"Red"},
        multi = true,
        seperator = true,
        callback = function(selected)
            print("[demo] multi select =", table.concat(selected, ", "))
        end,
    })

    local scrolling_items = {}
    for index = 1, 12 do
        scrolling_items[index] = "Entry " .. index
    end
    dropdowns:dropdown({
        name = "Scrolling list",
        items = scrolling_items,
        default = "Entry 1",
        scrolling = true,
        seperator = true,
        callback = function(value)
            print("[demo] scrolling =", value)
        end,
    })

    local binds = section(inputs_right, "Keybinds", 0.4)
    binds:keybind({
        name = "Hold bind",
        key = Enum.KeyCode.G,
        mode = "Hold",
        callback = function(active)
            print("[demo] hold bind =", active)
        end,
    })
    binds:keybind({
        name = "Toggle bind",
        key = Enum.KeyCode.H,
        mode = "Toggle",
        callback = function(active)
            print("[demo] toggle bind =", active)
        end,
    })
    binds:label({
        name = "Rebinding",
        info = "Click a key chip to rebind it. Right click the chip (or press ⋯ on touch) to switch Hold / Toggle / Always.",
    })
end

--------------------------------------------------------------------------------
-- Layout: columns, tab boxes and fading sections
--------------------------------------------------------------------------------
window:seperator({name = "Interface"})

local columns_page, tab_box_page, fading_page = make_tab({
    name = "Layout",
    tabs = subtabs({"Columns", "Tab Box", "Fading"}),
})

do
    local titles = {"Column One", "Column Two", "Column Three"}
    for index, title in ipairs(titles) do
        local group = section(columns_page:column({}), title, 1)
        group:label({
            name = title,
            info = "Each page can hold several columns side by side. This is column " .. index .. " of 3.",
        })
        if index == 1 then
            group:toggle({name = "Toggle in column one", seperator = true, callback = function(on) print("[demo] column one =", on) end})
        elseif index == 2 then
            group:slider({name = "Slider in column two", min = 0, max = 100, default = 25, interval = 1, seperator = true, callback = function(value) print("[demo] column two =", value) end})
        else
            group:button({name = "Button in column three", callback = function() notify("Columns", "Buttons work in any column.") end})
        end
    end
end

do
    local box = tab_box_page:tabbox({side = "middle"})

    local box_left = box_tab(box, "Left Box")
    local box_middle = box_tab(box, "Middle Box")
    local box_right = box_tab(box, "Right Box")

    local left_section = section(box_left:column({}), "Left Box", 1)
    left_section:label({
        name = "Tab box",
        info = "tabbox:tab({name, icon}) adds a sub tab. side = \"left\" | \"middle\" | \"right\" aligns the strip.",
    })
    left_section:toggle({name = "Box toggle", seperator = true, callback = function(on) print("[demo] box left =", on) end})

    local middle_section = section(box_middle:column({}), "Middle Box", 1)
    middle_section:slider({name = "Box slider", min = 0, max = 100, default = 60, interval = 1, seperator = true, callback = function(value) print("[demo] box middle =", value) end})
    middle_section:label({name = "Independent tabs", info = "Each tab box keeps its own tab set and page state."})

    local right_section = section(box_right:column({}), "Right Box", 1)
    right_section:label({
        name = "Runtime icons",
        info = "Box sub-tab icons are editable with box:set_tab_icon(name, icon) or page:set_icon(icon).",
    })
    right_section:button({name = "Refresh box icons", seperator = true, callback = function() refresh_icons() notify("Tab box", "Name-based icons re-applied.") end})
end

do
    local fade_left = fading_page:column({})
    local collapsible = section(fade_left, "Collapsible", 0.5, {fading = true, default = true})
    collapsible:label({name = "Fading section", info = "Click the header to fade this section's widgets out and back in."})
    collapsible:toggle({name = "Fade me", seperator = true, callback = function(on) print("[demo] collapsible =", on) end})

    local stable = section(fade_left, "Stable", 0.5)
    stable:label({name = "Always visible", info = "Sections without fading = true stay fully opaque."})

    local fade_right = fading_page:column({})
    local collapsed = section(fade_right, "Collapsed", 1, {fading = true, default = false})
    collapsed:label({name = "Collapsed by default", info = "This one starts faded with default = false."})
    collapsed:toggle({name = "Hidden widget", seperator = true, callback = function(on) print("[demo] collapsed =", on) end})
end

--------------------------------------------------------------------------------
-- Windows: resizing, the sub window and the mini window
--------------------------------------------------------------------------------
local windows_page = make_tab({name = "Windows", tabs = subtabs({"Main"})})

do
    local window_section = section(windows_page:column({}), "Main Window", 1)

    window_section:button({
        name = "Desktop (700 x 565)",
        callback = function()
            window:set_size(700, 565)
            window.apply_viewport()
        end,
    })
    window_section:button({
        name = "Compact (480 x 400)",
        callback = function()
            window:set_size(480, 400)
            window.apply_viewport()
        end,
    })
    window_section:button({
        name = "Small (320 x 300)",
        callback = function()
            window:set_size(320, 300)
            window.apply_viewport()
        end,
    })
    window_section:button({
        name = "Re-fit to viewport",
        callback = function()
            window.apply_viewport()
        end,
    })
    window_section:toggle({
        name = "Auto resize",
        default = initial_auto_resize,
        seperator = true,
        callback = function(on)
            window.auto_resize = on
            window.apply_viewport()
        end,
    })
    window_section:toggle({
        name = "Resize grip",
        default = true,
        callback = function(on)
            library:set_resize_handles_visible(on)
        end,
    })
end

do
    local windows_right = windows_page:column({})

    local sub_section = section(windows_right, "Sub Window", 0.5)
    sub_section:button({
        name = "Show notes",
        callback = function()
            notes:open()
            notify("Sub window", "notes:open()")
        end,
    })
    sub_section:button({
        name = "Hide notes",
        callback = function()
            notes:close()
            notify("Sub window", "notes:close()")
        end,
    })
    sub_section:button({
        name = "Retitle notes",
        callback = function()
            notes:set_title("Notes")
            notify("Sub window", "notes:set_title(\"Notes\")")
        end,
    })

    local mini_section = section(windows_right, "Mini Window", 0.5)
    mini_section:toggle({
        name = "Collapsed",
        default = false,
        callback = function(on)
            mini:set_collapsed(on)
        end,
    })
    mini_section:button({name = "Minimize", callback = function() mini:minimize() end})
    mini_section:button({name = "Expand", callback = function() mini:expand() end})
    mini_section:button({name = "Toggle collapse", callback = function() mini:toggle_collapsed() end})
end

--------------------------------------------------------------------------------
-- Icons: provider, name-based re-apply, icon size, theme, notifications
--------------------------------------------------------------------------------
local icons_page = make_tab({name = "Icons", tabs = subtabs({"Main"})})

do
    local icons_left = icons_page:column({})

    local provider_section = section(icons_left, "Provider", 0.55)
    provider_section:dropdown({
        name = "Icon provider",
        items = PROVIDERS,
        default = library.icon_provider,
        seperator = true,
        callback = function(provider)
            local ok, err = library:set_icon_provider(provider)
            if not ok then
                notify("Icon provider", tostring(err))
                return
            end
            refresh_icons()
            notify("Icon provider", "Every name resolved again for " .. provider .. ".")
        end,
    })
    provider_section:button({
        name = "Re-apply name icons",
        callback = function()
            refresh_icons()
            notify("Icons", "Re-applied " .. #named_icons .. " name-based icons.")
        end,
    })
    provider_section:label({
        name = "Name mapping",
        info = "ICONS maps each tab / sub tab / group box NAME to a provider icon. Change an entry and that name's icon changes everywhere.",
    })

    local theme_section = section(icons_left, "Theme", 0.45)
    theme_section:colorpicker({
        name = "Accent",
        color = library.themes.preset.accent,
        seperator = true,
        callback = function(color)
            library:update_theme("accent", color)
        end,
    })
    theme_section:button({
        name = "Reset accent",
        callback = function()
            library:update_theme("accent", DEFAULT_ACCENT)
        end,
    })
end

do
    local icons_right = icons_page:column({})

    local size_section = section(icons_right, "Icon Size", 0.5)
    size_section:button({
        name = "Icons 16 px",
        callback = function()
            library:set_icon_size(size_section, 16)
        end,
    })
    size_section:button({
        name = "Icons 22 px",
        callback = function()
            library:set_icon_size(size_section, 22)
        end,
    })
    size_section:button({
        name = "Icons 30 px",
        callback = function()
            library:set_icon_size(size_section, 30)
        end,
    })

    local extras = section(icons_right, "Extras", 0.5)
    extras:button({
        name = "Show notification",
        callback = function()
            notify("Notification", "Created with library.notifications:create_notification.")
        end,
    })
    extras:button({
        name = "Re-select window",
        callback = function()
            window:select()
            notify("Window", "window:select() restored popup ownership to the main window.")
        end,
    })
    extras:label({name = "Popup ownership", info = "Dropdowns and color pickers open in whichever window was last selected."})
end

--------------------------------------------------------------------------------
-- Sub window: same tab/column/section/widget API as the main window
--------------------------------------------------------------------------------
notes = library:sub_window({
    name = "Notes",
    suffix = ".lua",
    position = UDim2.new(0, 40, 0, 220),
    icon = resolve_icon("page", "Notes"),
})

do
    local notes_page = page_tab(notes, "Notes")
    local notes_section = section(notes_page:column({}), "Notes", 1)
    notes_section:toggle({
        name = "Pin notes",
        default = true,
        seperator = true,
        callback = function(on)
            print("[notes] pinned =", on)
        end,
    })
    notes_section:slider({
        name = "Note size",
        min = 8,
        max = 32,
        default = 14,
        interval = 1,
        suffix = " px",
        seperator = true,
        callback = function(value)
            print("[notes] size =", value)
        end,
    })
    notes_section:textbox({
        name = "Quick note",
        placeholder = "write a note...",
        callback = function(text)
            print("[notes] text =", text)
        end,
    })
end

do
    local more_page = page_tab(notes, "More")
    local more_section = section(more_page:column({}), "More", 1)
    more_section:dropdown({
        name = "Note color",
        items = {"Yellow", "Green", "Blue", "Pink"},
        default = "Yellow",
        seperator = true,
        callback = function(value)
            print("[notes] color =", value)
        end,
    })
    more_section:colorpicker({
        name = "Picker",
        color = Color3.fromRGB(255, 214, 102),
        alpha = 0,
        seperator = true,
        callback = function(color, alpha)
            print("[notes] picker =", color, alpha)
        end,
    })
    more_section:label({
        name = "Popups stay inside",
        info = "Dropdowns and color pickers created in this sub window open here, not over the main window.",
    })
end

--------------------------------------------------------------------------------
-- Mini window: compact sub window with collapse
--------------------------------------------------------------------------------
mini = library:mini_window({
    name = "Mini",
    suffix = ".lua",
    position = UDim2.new(0, 40, 0, 560),
    icon = resolve_icon("page", "Quick"),
})

do
    local quick_page = page_tab(mini, "Quick")
    local quick_section = section(quick_page:column({}), "Quick", 1)
    quick_section:toggle({
        name = "Mini checkbox",
        type = "checkbox",
        default = true,
        seperator = true,
        callback = function(on)
            print("[mini] checkbox =", on)
        end,
    })
    quick_section:slider({
        name = "Mini slider",
        min = 0,
        max = 100,
        default = 40,
        interval = 1,
        seperator = true,
        callback = function(value)
            print("[mini] slider =", value)
        end,
    })
    quick_section:button({
        name = "Collapse this mini window",
        callback = function()
            mini:toggle_collapsed()
        end,
    })
end

-- Builds the built-in "Settings" tab: config manager + interface + theme.
-- Always call this last so the config list refreshes after every widget exists.
library:init_config(window)
