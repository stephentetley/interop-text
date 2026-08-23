/*
 * Copyright 2026 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pub mod InteropText.RuleBasedCollator {

    use JavaInterop.AdaptorExtras
    use InteropLocale.Locale

    use InteropText.CollationKey

    import java.text.{RuleBasedCollator => JRuleBasedCollator}

    pub enum RuleBasedCollator(JRuleBasedCollator)
    


    instance ToJava[RuleBasedCollator] {
        type Out = JRuleBasedCollator
        pub def toJava(x: RuleBasedCollator): JRuleBasedCollator = 
            let RuleBasedCollator.RuleBasedCollator(x1) = x;
            x1
    }

    instance ToFlix[RuleBasedCollator] {
        type In = JRuleBasedCollator
        pub def toFlix(x: JRuleBasedCollator): RuleBasedCollator = 
            RuleBasedCollator.RuleBasedCollator(x)
    }




    /// Put collator as first argument for partial application

    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(x: RuleBasedCollator, s1: String, s2: String): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.equals(s1, s2) })

    ///
    /// Compare strings `s1` and `s2` with the collator `x`.
    ///
    pub def compare(x: RuleBasedCollator, s1: String, s2: String): Comparison =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { let cmp = x1.compare(s1, s2); Comparison.fromInt32(cmp) }
        )


    pub def getCollationKey(src: String, x: RuleBasedCollator): CollationKey = 
        AdaptorExtras.op(x, x1 -> unsafe IO { x1.getCollationKey(src) })

    pub def getRules(x: RuleBasedCollator): String =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getRules() })


}

