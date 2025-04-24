import { Word } from "../model/word"
import { getRandomInt } from "../util/util"

@Component
export struct Learn {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') learnIdx: Array<number> = []
  @State wordList: Array<Word> = []
  @State @Watch('onChangeIndex') selectedIndex: number = 0

  aboutToAppear(): void {
    Object.values(this.jsonWord!).forEach((word: Array<Word>) => {
      word.forEach(w => {
        this.wordList.push(w)
      })
    })

    this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
  }

  onChangeIndex(){
    if (this.learnIdx.indexOf(this.selectedIndex) == -1) {
      this.learnIdx.push(this.selectedIndex)
    }
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        Row().height(20)
        Row() {
          Column({ space: 8 }) {
            Text("今日复习")
            Text("0/10")
          }

          Column({ space: 8 }) {
            Text("今日新词")
            Text("0/10")
          }

          Column({ space: 8 }) {
            Text("学习时间")
            Text("1min")
          }
        }
        .borderRadius(2)
        .padding(16)
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')

        Text(this.wordList[this.selectedIndex].word)
          .fontColor("#000")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Text(this.wordList[this.selectedIndex].mean).fontColor("#000")

        Row().height(100)
        Row({space:20}) {
          Button("不认识", { type: ButtonType.Normal })
            .borderRadius(4)
            .width(100)
            .height(100)
            .fontColor('#F6752C')
            .backgroundColor("#eee")

          Button("我认识", { type: ButtonType.Normal })
            .borderRadius(4)
            .width(100)
            .height(100)
            .fontColor('#4EDD90')
            .backgroundColor("#eee")
            .onClick(()=>{
              this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
            })
        }
      }
      .padding({ left: 16, right: 16 })
    }
    .title("学习")
    .padding({
      top: 40,
    })
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}