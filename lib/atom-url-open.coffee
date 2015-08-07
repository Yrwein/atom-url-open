
shell = require 'shell'

module.exports = AtomUrlOpen =

    activate: (state) ->
        atom.commands.add 'atom-text-editor', 'atom-url-open:open': => @openUrl()

    openUrl: ->
        return unless editor = atom.workspace.getActiveTextEditor()

        selection = editor.getSelectedText()

        url = ""
        if selection
            url = selection
        else
            cursorPosition = editor.getLastCursor().getBufferColumn()
            line = editor.getLastCursor().getCurrentBufferLine()
            urlPartBeforeCursor = line.substr(0, cursorPosition).replace(/.*[\s\(\),]/, "")
            urlPartAfterCursor = line.substr(cursorPosition).replace(/[\s\(\),].*/, "")
            url = urlPartBeforeCursor + urlPartAfterCursor

        if url.match(/^https?/)
            shell.openExternal(url)
