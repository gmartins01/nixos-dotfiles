import { App } from "astal/gtk3"
import style from "./style/main.scss"
import Bar from "./src/components/bar/Bar"

App.start({
    css: style,
    main() {
        App.get_monitors().map(Bar)
    },
})
