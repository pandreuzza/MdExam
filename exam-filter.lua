-- Div block: surrounds block with "begin" and "end"
function Div(el)

  if el.classes[1] == "special" then
    return{
    pandoc.RawBlock("latex", "\\ifbool{specialVersion}{"),
    el,
    pandoc.RawBlock("latex", "}{}")
    }
  end
  if el.classes[1] == "nspecial" then
    return{
    pandoc.RawBlock("latex", "\\ifbool{specialVersion}{}{"),
    el,
    pandoc.RawBlock("latex", "}")
    }
  end
  -- "p" citation to \part
  if el.classes[1] == "parts" then
    el = pandoc.walk_block(el, {
      Cite = function(el)
        local outputString=""
        if el.citations[1].id == "p" then
          outputString = "\\part"
        end
      return pandoc.RawInline("latex", outputString)
      end
    })
  
  --[[ transform the block name: in this way I can use a shorter name in md source
      "opcb" for one para checkboxes block (oneparcheckboxes)
      "cb" for checkboxes block (checkboxes)
  ]]
  elseif el.classes[1] == "opcb" or el.classes[1] == "cb" then
    if el.classes[1] == "opcb" then
      el.classes[1] = "oneparcheckboxes"
    elseif el.classes[1] == "cb" then
      el.classes[1] = "checkboxes"
    end
      el = pandoc.walk_block(el, {
      Cite = function(el)
        local outputString=""
        -- "c" citation to \choice
        if el.citations[1].id == "c" then
          outputString = "\\choice"
        -- "c" citation to \CorrectChoice  
        elseif el.citations[1].id == "cc" then
          outputString = "\\CorrectChoice"
        end
      return pandoc.RawInline("latex", outputString)
      end
    })
  end

  return {
    pandoc.RawBlock("latex", "\\begin{" .. el.classes[1] .. "}"),
    el,
    pandoc.RawBlock("latex", "\\end{" .. el.classes[1] .. "}")
  }
end

-- Transform the "q" citation in exam questions block
function Cite (cite)
  local outputString=""

  if cite.citations[1].id == "q" then
    outputString = "\\question"
    if cite.content[3] then
      outputString = outputString .. " " .. pandoc.utils.stringify(cite.content[3])
    end
  else
      return cite
  end
  return pandoc.RawInline("latex", outputString)
end

-- set bold the questions
function Para(para)
  if para.content[1].format == "latex" and para.content[1].text:find("\\question") then
    table.insert(para.content, 3, pandoc.RawInline('latex', '\\textbf{'))
    table.insert(para.content, pandoc.RawInline('latex', '}'))
  end

  para = pandoc.walk_block(para, {
    Cite = function(el)
      -- hrule fill: an optioinal parameter can give the number of lines to insert
      if el.citations[1].id == "hf" then
        if not next(el.citations[1].suffix) then
          return pandoc.RawInline('latex', '\\hrulefill')
        else
          myBlock = {}
          for y=el.citations[1].suffix[1].text,1,-1 do 
            newInline = pandoc.RawInline('latex', '\\hrulefill\n\n')
            table.insert(myBlock,newInline)
          end
          return (myBlock)
        end
      end

      -- Line to fill: 
      if el.citations[1].id == "tf" then
        local answer, lenght
        if not next(el.citations[1].suffix) then
          return pandoc.RawInline('latex', '\\fillin')
        else
          if string.find(el.citations[1].suffix[1].text, ",") then
            answer, lenght = string.match(el.citations[1].suffix[1].text, "(.*),%s*(.*)")
            if lenght == "" then
              lenght = "0,8"
            end
            lenght = lenght .. "cm"
            return (pandoc.RawInline('latex', '\\fillin['.. answer ..'][' .. lenght .. ']'))
          else
            answer = el.citations[1].suffix[1].text
          end
          return (pandoc.RawInline('latex', '\\fillin['.. answer ..']'))
        end
      end

      -- Empty box: with or without dimension (if size is not present, uses 5cm as default)
      if el.citations[1].id == "eb" then
        myBlock = {}
        if not next(el.citations[1].suffix) then
          myBlock = pandoc.RawInline('latex', '\\makeemptybox{5cm}')
        else
          myBlock = pandoc.RawInline('latex', '\\makeemptybox{' .. el.citations[1].suffix[1].text .. 'cm}')
        end
        return (myBlock)
      end

    end
  })
  return para
end
