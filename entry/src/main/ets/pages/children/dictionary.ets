import { VerifyCodeComponentWithoutCursor } from "../component/textinput"

@Component
export struct DictionaryPage {
  @State code: string = ''

  build() {
    Column() {
      Text("背单词")
      VerifyCodeComponentWithoutCursor()
    }
  }
}