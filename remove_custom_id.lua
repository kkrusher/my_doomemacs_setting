-- remove all attributes when convert markdown to orgmode using pandoc
-- https://emacs.stackexchange.com/questions/54400/export-a-docx-file-to-org-using-pandoc-but-without-the-property-drawers
function Header (header)
  return pandoc.Header(header.level, header.content, pandoc.Attr())
end
