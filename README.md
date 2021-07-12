# Markly-Swift

Swift implementation of Markly. A micro subset of Markdown.

## Differences with Markdown.

Markly only supports the most basic and safe subset of Markdown: paragraphs,
bold text, and unordered lists. Everything else is not supported. However, there are some differences in how these features work.

### Bold text

Markly uses single asterisks `*` as the delimiter for bold text:

```markdown
*bold* text
```

### Unordered lists

Just like Markdown, consecutive lines that start with dashes or asterisks followed by a space will render as an unordered list. However, nested lists aren't supported in Markly.

```markdown
- Item one
- Item two
- Item three

or

* Item one
* Item two
* Item three
```

### Paragraphs and line breaks

In Markdown, hard line breaks [are ignored](https://daringfireball.net/projects/markdown/syntax#p)
for valid reasons. In Markly, line breaks are always preserved. For example, the following will render as-is:

```markdown
Hello
world
```

## Usage

Markly-Swift allows you to create attributed strings from a
markly-formatted string via the `NSAttributedString.markly()` static method.


```swift
import Markly

// ...

let marklyContent = "*Hello world*"
textView.attributedString = NSAttributedString.markly(marklyContent)
```

The generated attributed string will use the default system font and label
color. But you can override this behavior by providing your own style preferences:

```swift
textView.attributedString = NSAttributedString.markly(marklyContent, style: MarklyStyle(
    color: UIColor.red,
    font: UIFont(name: "CustomFont", size: 16),
    boldFont: UIFont(name: "CustomFont-Bold", size: 16)
))
```

## Related libraries

* [Original implementation in TypeScript](https://github.com/raymondjavaxx/markly)
