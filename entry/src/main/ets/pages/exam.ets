import { Word } from '../model/word';
import { getRandomInt } from '../util/util';
import { VerifyCodeComponentWithoutCursor } from './component/textinput';
import { emitter } from '@kit.BasicServicesKit';

@Component
export struct Exam {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') learnIdx: Array<number> = []
  @StorageLink('unknownIdx') unknownIdx: Array<number> = []
  @State wordList: Array<Word> = []
  @State selectedIndex: number = 0
  @State isFromErro: boolean = false
  @Consume navStack: NavPathStack;

  aboutToAppear(): void {
    const allWorks: Array<Array<Word>> = Object.values(this.jsonWord!);
    this.wordList = allWorks.flat()
    this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
    const params: Array<ESObject> = this.navStack.getParamByName("exam")

    if (params?.length && params[0]) {
      this.isFromErro = true
      const word: Word = params[0]
      this.selectedIndex = this.wordList.findIndex((w) => (w.word == word.word && w.mean == word.mean))
    } else {
      this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
    }
  }

  onNext() {
    this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
  }

  build() {
    NavDestination() {
      Column({ space: 16 }) {
        Text(this.wordList[this.selectedIndex].mean)
          .fontColor("#000")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        VerifyCodeComponentWithoutCursor({
          currentWordIdx: this.selectedIndex,
          currentWord: this.wordList[this.selectedIndex].word,
          onFinish: (text: string, cu: string) => {
            console.log("当前的单词", cu, text)
          },
          onError: () => {
          },
          onRight: () => {
            console.log('---', JSON.stringify(this.unknownIdx), this.selectedIndex)
            const index = this.unknownIdx.indexOf(this.selectedIndex)
            console.log("index", index)
            if (index > -1) {
              this.unknownIdx.splice(index, 1)
            }
            if (!this.isFromErro) {
              this.onNext()
            } else {
              this.navStack.pop()
            }
          }
        })

        Row().layoutWeight(1)
        if (!this.isFromErro) {
          Button("下一题").alignSelf(ItemAlign.End)
            .onClick(() => {
              emitter.emit({
                eventId: 6
              })
              this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
            })
        }
        Row().height(80)
      }
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: 48,
        left: 16,
        right: 16
      })
    }
    .title("背单词")
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}