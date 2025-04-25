import { Word } from "../../model/word";

@Component
export struct HomePage {
  @Consume navStack: NavPathStack;
  @StorageProp('jsonWord') jsonWord: object | undefined = undefined
  @StorageLink('learnIdx') @Watch('onLearn') learnIdx: Array<number> = []
  @State words: Array<Word> = []
  @State percent: string = '0'

  aboutToAppear(): void {
    const allWorks: Array<Array<Word>> = Object.values(this.jsonWord!);
    this.words = allWorks.flat()
    this.onLearn()
  }

  onLearn() {
    this.percent = (this.learnIdx.length / this.words.length).toFixed(3)
  }

  build() {
    Column({ space: 20 }) {
      Row().height(68)
      Text('已打卡天数')
      Text('0').fontSize(24).fontWeight(FontWeight.Bold)
      Row().height(30)

      Column() {
        Row() {
          Text("四级真题核心词汇书")
          Text("词表")
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(20)
        Row() {
          Text(`已学${this.percent}%`)
          Text(`${this.learnIdx.length}/${this.words.length}词`)
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(8)
        Progress({ value: this.learnIdx.length, total: this.words.length, type: ProgressType.Linear })
      }
      .borderRadius(8)
      .backgroundColor("#fff")
      .padding(16)
      .width('100%')

      Row().height(80)
      Button("开始学习")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .onClick(() => {
          this.navStack.pushPathByName('learn', undefined)
        })

      Button("开始考试")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .onClick(() => {
          this.navStack.pushPathByName('exam', undefined)
        })
    }
    .padding({
      top: 50,
      left: 16,
      right: 16
    })
    .height('100%')
    .width('100%')
  }
}