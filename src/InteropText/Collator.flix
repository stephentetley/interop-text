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

pub mod InteropText.Collator {

    use JavaInterop.AdaptorExtras
    use InteropLocale.Locale


    import java.text.{Collator => JCollator}

    ///
    /// Class / Represents a Collator.
    ///
    /// Consider Collator "Immutable after init" so we can use it 
    /// without a region.
    ///
    pub enum Collator(JCollator)
    
    /// TODO CollatorBuilder

    instance ToJava[Collator] {
        type Out = JCollator
        pub def toJava(x: Collator): JCollator = 
            let Collator.Collator(x1) = x;
            x1
    }

    instance ToFlix[Collator] {
        type In = JCollator
        pub def toFlix(x: JCollator): Collator = 
            Collator.Collator(x)
    }


    pub def no_decomposition(): Int32 = unsafe IO { JCollator.NO_DECOMPOSITION }

    pub def canonical_decomposition(): Int32 = unsafe IO { JCollator.CANONICAL_DECOMPOSITION }

    pub def full_decomposition(): Int32 = unsafe IO { JCollator.FULL_DECOMPOSITION }



    pub def identical(): Int32 = unsafe IO { JCollator.IDENTICAL }

    pub def primary(): Int32 = unsafe IO { JCollator.PRIMARY }

    pub def secondary(): Int32 = unsafe IO { JCollator.SECONDARY }

    pub def tertiary(): Int32 = unsafe IO { JCollator.TERTIARY }


    ///
    /// Get a Collator with the locale of the JVM.
    /// Apply the setters in `fs` to further configure the Collator.
    ///
    pub def getInstance(): Collator \ IO =
        AdaptorExtras.of(() -> JCollator.getInstance())
    

    pub def getInstanceWithLocale(loc: Locale): Collator =
        AdaptorExtras.op(loc, loc1 -> unsafe IO { JCollator.getInstance(loc1) })



    /// Put collator as first argument for partial application

    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(x: Collator, s1: String, s2: String): Bool =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.equals(s1, s2) })

    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(x: Collator, s1: String, s2: String): Comparison =
        AdaptorExtras.extract(x, x1 -> 
            unsafe IO { let cmp = x1.compare(s1, s2); Comparison.fromInt32(cmp) }
        )



    pub def getDecomposition(x: Collator): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getDecomposition() })


    pub def getStrength(x: Collator): Int32 =
        AdaptorExtras.extract(x, x1 -> unsafe IO { x1.getStrength() })


    // Builder?

    // pub def setDecomposition!(mode: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setDecomposition(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setDecomposition(c1, mode)

    // pub def setStrength!(strength: Int32, c: MutCollator[r]): Unit \ r =
    //     import java.text.Collator.setStrength(Int32): Unit \ r;
    //     let MutCollator(c1) = c;
    //     setStrength(c1, strength)

}

