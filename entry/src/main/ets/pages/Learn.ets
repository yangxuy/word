import { LearnDayProp, Word } from "../model/word"
import { getRandomInt, getToday } from "../util/util"

@Component
export struct Learn {
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') learnIdx: Array<number> = []
  @StorageLink('unknownIdx') unknownIdx: Array<number> = []
  @State wordList: Array<Word> = []
  @State @Watch('onChangeIndex') selectedIndex: number = 0
  @Consume navStack: NavPathStack;
  @StorageLink('learnDay') learnDay: LearnDayProp = { word: 0, time: '0', duration: 0 }
  private startTime: number = 0
  private timerId: number = 0

  aboutToAppear(): void {
    this.startTime = Date.now()
    const allWorks: Array<Array<Word>> = Object.values(this.jsonWord!);
    this.wordList = allWorks.flat()
    const params: Array<ESObject> = this.navStack.getParamByName("learn")
    if (params?.length && params[0]) {
      const word: Word = params[0]
      this.selectedIndex = this.wordList.findIndex((w) => w.word == word.word)
    } else {
      this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
    }
    const getDay = getToday()
    if (this.learnDay.time != getDay) {
      this.learnDay.duration = 0;
      this.learnDay.time = getDay;
      this.learnDay.word = 0;
    }
    this.timerId = setInterval(() => {
      this.learnDay.duration++;
    }, 60000)
  }

  onChangeIndex() {
    if (this.learnIdx.indexOf(this.selectedIndex) == -1) {
      this.learnIdx.push(this.selectedIndex)
    }
  }

  nextWord() {
    this.selectedIndex = getRandomInt(0, this.wordList.length - 1)
    this.learnDay.word++;
  }

  aboutToDisappear() {
    clearInterval(this.timerId)
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        Row() {
          Column({ space: 8 }) {
            Text("今日学习")
            Text(`${this.learnDay.word}`)
          }

          Column({ space: 8 }) {
            Text("学习时间")
            Text(`${this.learnDay.duration}min`)
          }
        }
        .borderRadius(2)
        .padding(16)
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')

        Text(this.wordList[this.selectedIndex].word)
          .fontColor("#000")
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        Text(this.wordList[this.selectedIndex].mean).fontColor("#000")

        Row().height(100)
        Row({ space: 20 }) {
          Button("不认识", { type: ButtonType.Normal })
            .borderRadius(4)
            .width(100)
            .height(100)
            .fontColor('#F6752C')
            .backgroundColor("#eee")
            .onClick(() => {
              if (!this.unknownIdx.includes(this.selectedIndex)) {
                this.unknownIdx.push(this.selectedIndex)
              }
              this.nextWord()
            })

          Button("我认识", { type: ButtonType.Normal })
            .borderRadius(4)
            .width(100)
            .height(100)
            .fontColor('#4EDD90')
            .backgroundColor("#eee")
            .onClick(() => {
              this.nextWord()
            })
        }
      }
      .padding({ left: 16, right: 16 })
    }
    .title("学习")
    .backgroundColor('#F8F9FB')
    .backgroundImage($r('app.media.person_bg'))
  }
}